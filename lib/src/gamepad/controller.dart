import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:win32/win32.dart';
import 'package:xinput_gamepad/src/models/controller_battery.dart';
import 'package:xinput_gamepad/src/models/controller_capabilities.dart';
import 'package:xinput_gamepad/src/utils/controller_utils.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';
import 'package:xinput_gamepad/src/utils/controller_list_utils.dart';

///Used to simulate events using a XInput controller.
///
///```dart
///final Controller controller = Controller(index: controllerIndex);
///```
class Controller {
  //Controller mode and identifier
  ///Index of the controller in XInput system.
  final int index;

  ///Controller button mode.
  final ButtonMode buttonMode;

  //Controller state
  ///Get the actual state of the controller.
  ///
  ///If true, the controller is running and listening inputs.
  ///If false, controller isn't listening inputs.
  bool get activated {
    return _controllerListenerSubscription == null
        ? false
        : !_controllerListenerSubscription!.isPaused;
  }

  ///Set the state of the controller.
  set activated(bool value) {
    value
        ? _controllerListenerSubscription?.resume()
        : _controllerListenerSubscription?.pause();
  }

  //XInput state
  int _dwPacketNumber = 0;
  late XINPUT_GAMEPAD _lastGamepadValidState;

  //Controller informations
  ///Retrives the controller capababilities.
  late ControllerCapababilities _capababilities;
  ControllerCapababilities get capababilities {
    return _capababilities;
  }

  ///Retrives the controller's battery.
  late ControllerBattery _batteryInformation;
  ControllerBattery get batteryInformation {
    return _batteryInformation;
  }

  //Maping
  ///Set the initial mapping of the controller's buttons.
  ///```dart
  ///controller.buttonsMapping = {
  ///    ControllerButton.A_BUTTON: () =>
  ///        print("Controller $controllerIndex - Button A"),
  ///    ControllerButton.B_BUTTON: () =>
  ///        print("Controller $controllerIndex - Button B"),
  ///    ControllerButton.X_BUTTON: () =>
  ///        print("Controller $controllerIndex - Button X"),
  ///    ControllerButton.Y_BUTTON: () =>
  ///        print("Controller $controllerIndex - Button Y")
  ///};
  ///```
  Map<ControllerButton, Function>? buttonsMapping;

  ///Set a new [buttonMapping] from [variantsButtonsMapping] mapping list.
  set buttonsFromMappingList(int mappingIndex) {
    buttonsMapping = variantsButtonsMapping?[mappingIndex];
  }

  ///List of variant buttons mappings.
  List<Map<ControllerButton, Function>>? variantsButtonsMapping;

  ///Set the initial mapping of the controller's variable buttons.
  ///```dart
  ///controller.variableKeysMapping = {
  ///    VariableControllerKey.LEFT_TRIGGER: (value) =>
  ///        print("Controller $controllerIndex - LEFT TRIGGER - $value"),
  ///    VariableControllerKey.RIGHT_TRIGGER: (value) =>
  ///        print("Controller $controllerIndex - RIGHT TRIGGER - $value")
  ///};
  ///```
  Map<VariableControllerKey, Function(int value)>? variableKeysMapping;

  ///Set a new [variableKeysMapping] from [variantsVariableKeyMapping] mapping list.
  set variableKeyFromMappingList(int mappingIndex) {
    variableKeysMapping = variantsVariableKeyMapping?[mappingIndex];
  }

  ///List of variant variable buttons mappigns.
  List<Map<VariableControllerKey, Function(int value)>>?
      variantsVariableKeyMapping;

  //Events
  ///Occurs when a controller's button is realeased.
  ///Gives what button has been released in ```button``` parameter.
  ///
  ///```dart
  ///controller.onReleaseButton = (button) => print("$button has ben released");
  ///```
  Function(ControllerButton button)? onReleaseButton;

  ///Set a callback to retrieve and manipulate the raw button bitmask.
  ///If this callback is not null, the bitmask will go through it and
  /// the package's bitmask manipulation will not be used.
  Function(int bitmask)? onRawButtonEvent;

  //Vibration
  //Available range: 0-65535
  ///Set the speed of the vibartion of the left motor.
  ///Available range: 0-65535
  int leftVibrationSpeed;

  ///Set the speed of the vibration of the right motor.
  ///Available range: 0-65535
  int rightVibrationSpeed;

  //Deadzone
  ///Set the deadzone of the controllers's left thumb.
  int leftThumbDeadzone;

  ///Set the deadzone of the controllers's right thumb.
  int rightThumbDeadzone;

  ///Set the deadzone of the controller's triggers.
  int triggersDeadzone;

  ///Instantiate a new [Controller].
  ///Set a initial controller index than can be retrived from [ControllersManager].
  ///and use to initialize a new controller.
  Controller(
      {required this.index,
      this.buttonsMapping,
      this.variantsButtonsMapping,
      this.variableKeysMapping,
      this.variantsVariableKeyMapping,
      this.onReleaseButton,
      this.onRawButtonEvent,
      this.buttonMode = ButtonMode.PRESS,
      this.leftVibrationSpeed = 16000,
      this.rightVibrationSpeed = 16000,
      this.leftThumbDeadzone = 7849,
      this.rightThumbDeadzone = 8689,
      this.triggersDeadzone = 30}) {
    _updateCapabilities();
    updateBatteryInfo();
  }

  bool _isValid() => ControllerUtils.isConnected(index);

  StreamSubscription? _controllerListenerSubscription;

  ///Start to listen inputs from the controller.
  void listen() async {
    final controllerStateStream = ControllerUtils.streamState(index)
        .where((event) => _dwPacketNumber != event.ref.dwPacketNumber);

    _controllerListenerSubscription = controllerStateStream.listen((event) {
      _dwPacketNumber = event.ref.dwPacketNumber;
      _lastGamepadValidState = event.ref.Gamepad;

      if (onRawButtonEvent != null) {
        onRawButtonEvent?.call(_lastGamepadValidState.wButtons);
      } else {
        _buttonsReact();
      }
      _thumbsTriggersReact();

      free(event);
    }, onError: (error) {
      print("A error occurs: $error");
    }, cancelOnError: false);
  }

  int? _lastButtonsBitmask;
  void _buttonsReact() {
    if (buttonsMapping == null) return;

    int buttonBitmask = _lastGamepadValidState.wButtons;

    //Check release button
    if (_lastButtonsBitmask != null && buttonBitmask < _lastButtonsBitmask!) {
      ControllerButton releasedButton = ControllerButton.convertFromBitmask(
              _lastButtonsBitmask! - buttonBitmask)!
          .first;
      onReleaseButton?.call(releasedButton);

      _lastButtonsBitmask = buttonBitmask == 0 ? null : buttonBitmask;
    }

    List<ControllerButton>? buttons =
        ControllerButton.convertFromBitmask(buttonBitmask);
    if (buttons == null) return;

    List<Function> pressMappedButtonsFunction = List.empty(growable: true);
    bool isMultiPress =
        _lastButtonsBitmask != null && buttonBitmask > _lastButtonsBitmask!;
    if (isMultiPress) {
      var newButtons = ControllerButton.convertFromBitmask(
          buttonBitmask - _lastButtonsBitmask!)!;
      buttons = buttons.getContains(newButtons);
    }
    for (ControllerButton button in buttons) {
      if (buttonsMapping!.containsKey(button)) {
        pressMappedButtonsFunction.add(buttonsMapping![button]!);
      }
    }

    for (Function pressAction in pressMappedButtonsFunction) {
      switch (buttonMode) {
        case ButtonMode.PRESS:
          //When the the current state's button is diferent than last.
          if (isMultiPress || _lastButtonsBitmask == null) {
            _lastButtonsBitmask = buttonBitmask;
            pressAction();
          }
          break;
        case ButtonMode.HOLD:
          //No matter if the last state's button is the same than this.
          _lastButtonsBitmask = buttonBitmask;
          pressAction();
          break;
      }
    }
  }

  void _thumbsTriggersReact() {
    final int leftTrigger = _lastGamepadValidState.bLeftTrigger;
    final int rightTrigger = _lastGamepadValidState.bRightTrigger;
    final int thumbLx = _lastGamepadValidState.sThumbLX;
    final int thumbLy = _lastGamepadValidState.sThumbLY;
    final int thumbRx = _lastGamepadValidState.sThumbRX;
    final int thumbRy = _lastGamepadValidState.sThumbRY;

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

  ///Vibrate the controller based on the values defined in [leftVibrationSpeed] and [rightVibrationSpeed].
  ///
  ///[duration] - Duration of how long the controller will be vibrating.
  Future vibrate(Duration duration) async {
    if (!_isValid()) return;

    Pointer<XINPUT_VIBRATION> vibration =
        ControllerUtils.getControllerVibration(
            leftVibrationSpeed, rightVibrationSpeed);
    XInputSetState(index, vibration);

    await Future.delayed(
        duration,
        (() => {
              ZeroMemory(vibration, sizeOf<XINPUT_VIBRATION>()),
              XInputSetState(index, vibration),
              free(vibration)
            }));
  }

  ///Update the actual battery information in ```batteryInformation```.
  void updateBatteryInfo() {
    final Pointer<XINPUT_BATTERY_INFORMATION> tempBatteryInfo =
        ControllerUtils.getBatteryInformation(index);
    _batteryInformation = ControllerBattery(tempBatteryInfo.ref);

    free(tempBatteryInfo);
  }

  void _updateCapabilities() {
    final Pointer<XINPUT_CAPABILITIES> tempCapabilities =
        ControllerUtils.getCapabilities(index);
    _capababilities = ControllerCapababilities(tempCapabilities.ref);

    free(tempCapabilities);
  }
}
