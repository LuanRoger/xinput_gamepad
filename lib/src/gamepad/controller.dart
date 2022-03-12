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
  //Controller mode and identifier
  final int index;
  final ButtonMode buttonMode;

  //Controller state
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

  //XInput state
  int _dwPacketNumber = 0;
  late XINPUT_GAMEPAD lastGamepadValidState;

  //Controller informations
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

  //Events
  Function(ControllerButton button)? onReleaseButton;

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
      this.onReleaseButton,
      this.buttonMode = ButtonMode.PRESS,
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

    //Set initial battery info
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
  void _buttonsReact() {
    final ControllerButton? button =
        InputBitmaskConverter.convertButton(lastGamepadValidState.wButtons);

    buttonsMapping?.forEach((mapedButtons, action) {
      //The button pressed is different than last.
      //This means the button has been released.
      if (_lastButtonPressed != null && button != _lastButtonPressed) {
        onReleaseButton?.call(_lastButtonPressed!);
        _lastButtonPressed = null;
      }

      switch (buttonMode) {
        case ButtonMode.PRESS:
          //When the the current state's button is diferent than last.
          if (_lastButtonPressed == null && button == mapedButtons) {
            _lastButtonPressed = button;
            action();
          }
          break;
        case ButtonMode.HOLD:
          //No matter if the last state's button is the same than this.
          if (button == mapedButtons) {
            _lastButtonPressed = button;
            action();
          }
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
