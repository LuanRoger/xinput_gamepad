import 'dart:async';
import 'dart:ffi';
import 'package:win32/win32.dart';
import 'package:ffi/ffi.dart';
import 'dart:math';
import 'package:xinput_gamepad/src/models/controller_battery.dart';
import 'package:xinput_gamepad/src/models/controller_capabilities.dart';
import 'package:xinput_gamepad/src/utils/controller_utils.dart';
import 'package:xinput_gamepad/src/utils/bitmask_converters/input_bitmask_converter.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class Controller {
  final int index;
  final ButtonsMode buttonsMode;
  bool get activated {
    return _controllerListenerSubscription == null
        ? false
        : !_controllerListenerSubscription!.isPaused;
  }

  set activated(bool value) {
    value
        ? _controllerListenerSubscription?.resume()
        : _controllerListenerSubscription?.pause();
  }

  int _dwPacketNumber = 0;
  late XINPUT_GAMEPAD lastGamepadValidState;
  late ControllerCapababilities _capababilities;
  ControllerCapababilities get capababilities {
    return _capababilities;
  }

  late ControllerBattery _batteryInformation;
  ControllerBattery get batteryInformation {
    return _batteryInformation;
  }

  //Maping
  Map<ControllerButton, Function>? buttonsMapping;
  Map<VariableControllerKey, Function(int value)>? variableKeysMapping;

  //Vibration
  //Available range: 0-65535
  int leftVibrationSpeed;
  int rightVibrationSpeed;
  late Pointer<XINPUT_VIBRATION> _vibration;

  //Deadzone
  int leftThumbDeadzone;
  int rightThumbDeadzone;
  int triggersDeadzone;

  Controller(
      {required this.index,
      this.buttonsMapping,
      this.variableKeysMapping,
      this.buttonsMode = ButtonsMode.PRESSED,
      this.leftVibrationSpeed = 16000,
      this.rightVibrationSpeed = 16000,
      this.leftThumbDeadzone = 7849,
      this.rightThumbDeadzone = 8689,
      this.triggersDeadzone = 30}) {
    //Set capabilities
    final Pointer<XINPUT_CAPABILITIES> tempCapabilities =
        ControllerUtils.getCapabilities(index);
    _capababilities = ControllerCapababilities(tempCapabilities.ref);

    free(tempCapabilities);

    //Set battery info
    updateBatteryInfo();
  }

  StreamSubscription? _controllerListenerSubscription;
  void lister() async {
    final controllerStateStream = ControllerUtils.streamState(index)
        .where((event) => _dwPacketNumber != event.ref.dwPacketNumber);

    _controllerListenerSubscription = controllerStateStream.listen((event) {
      _dwPacketNumber = event.ref.dwPacketNumber;
      lastGamepadValidState = event.ref.Gamepad;

      _buttonsReact();
      _thumbsTriggersReact();

      free(event);
    }, onError: (error) {
      print("A error occurs: $error");
    }, cancelOnError: false);
  }

  Future vibrate(Duration duration) async {
    _setVibration();
    XInputSetState(index, _vibration);

    await Future.delayed(
        duration,
        (() => {
              ZeroMemory(_vibration, sizeOf<XINPUT_VIBRATION>()),
              XInputSetState(index, _vibration),
              free(_vibration)
            }));
  }

  void updateBatteryInfo() {
    final Pointer<XINPUT_BATTERY_INFORMATION> tempBatteryInfo =
        ControllerUtils.getBatteryInformation(index);
    _batteryInformation = ControllerBattery(tempBatteryInfo.ref);

    free(tempBatteryInfo);
  }

  ControllerButton? _lastButtonPressed;
  final Stopwatch _inputPressedTime = Stopwatch();
  _buttonsReact() {
    final ControllerButton? button =
        InputBitmaskConverter.convertButton(lastGamepadValidState.wButtons);

    buttonsMapping?.forEach((mapedButtons, action) {
      switch (buttonsMode) {
        case ButtonsMode.PRESSED:
          if (!_inputPressedTime.isRunning) _inputPressedTime.start();

          if (_inputPressedTime.elapsed.inMilliseconds >
                  XInputManager.inputLag &&
              button != _lastButtonPressed) {
            _lastButtonPressed = null;
            _inputPressedTime.reset();
          }
          if (_lastButtonPressed == null && button == mapedButtons) {
            _lastButtonPressed = button;
            action();
          }
          break;
        case ButtonsMode.HOLD:
          if (button == mapedButtons) action();
          break;
      }
    });
  }

  void _thumbsTriggersReact() {
    final int leftTrigger = lastGamepadValidState.bLeftTrigger;
    final int rightTrigger = lastGamepadValidState.bRightTrigger;
    final int thumbLx = lastGamepadValidState.sThumbLX;
    final int thumbLy = lastGamepadValidState.sThumbLY;
    final int thumbRx = lastGamepadValidState.sThumbRX;
    final int thumbRy = lastGamepadValidState.sThumbRY;

    final double magnitudeL = sqrt(thumbLx * thumbLx + thumbLy * thumbLy);
    final double magnitudeR = sqrt(thumbRx * thumbRx + thumbRy * thumbRy);

    variableKeysMapping?.forEach((mapedKeys, action) {
      switch (mapedKeys) {
        case VariableControllerKey.LEFT_TRIGGER:
          if (leftTrigger > triggersDeadzone) action(leftTrigger);
          break;
        case VariableControllerKey.RIGHT_TRIGGER:
          if (rightTrigger > triggersDeadzone) action(rightTrigger);
          break;
        case VariableControllerKey.THUMB_LX:
          if (magnitudeL > leftThumbDeadzone) action(thumbLx);
          break;
        case VariableControllerKey.THUMB_LY:
          if (magnitudeL > leftThumbDeadzone) action(thumbLy);
          break;
        case VariableControllerKey.THUMB_RX:
          if (magnitudeR > rightThumbDeadzone) action(thumbRx);
          break;
        case VariableControllerKey.THUMB_RY:
          if (magnitudeR > rightThumbDeadzone) action(thumbRy);
          break;
      }
    });
  }

  void _setVibration() {
    if (!_isValid()) return;

    _vibration = calloc<XINPUT_VIBRATION>();
    ZeroMemory(_vibration, sizeOf<XINPUT_VIBRATION>());

    _vibration.ref.wLeftMotorSpeed = leftVibrationSpeed;
    _vibration.ref.wRightMotorSpeed = rightVibrationSpeed;
  }

  bool _isValid() => ControllerUtils.isConnected(index);
}
