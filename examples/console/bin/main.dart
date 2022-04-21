import 'dart:io';
import 'package:xinput_gamepad/xinput_gamepad.dart';

void main(List<String> arguments) {
  XInputManager.enableXInput();

  List<Controller> availableControllers = List.empty(growable: true);
  for (int controllerIndex
      in ControllersManager.getIndexConnectedControllers()) {
    final Controller controller =
        Controller(index: controllerIndex, buttonMode: ButtonMode.PRESS);
    controller.buttonsMapping = {
      ControllerButton.A_BUTTON: () =>
          print("Controller $controllerIndex - Button A"),
      ControllerButton.B_BUTTON: () =>
          print("Controller $controllerIndex - Button B"),
      ControllerButton.X_BUTTON: () =>
          print("Controller $controllerIndex - Button X"),
      ControllerButton.Y_BUTTON: () =>
          print("Controller $controllerIndex - Button Y"),
      ControllerButton.DPAD_UP: () =>
          print("Controller $controllerIndex - DPAD UP"),
      ControllerButton.DPAD_DOWN: () =>
          print("Controller $controllerIndex - DPAD DOWN"),
      ControllerButton.DPAD_LEFT: () =>
          print("Controller $controllerIndex - DPAD LEFT"),
      ControllerButton.DPAD_RIGHT: () =>
          print("Controller $controllerIndex - DPAD RIGHT"),
      ControllerButton.LEFT_SHOULDER: () =>
          print("Controller $controllerIndex - LEFT SHOULDER"),
      ControllerButton.RIGHT_SHOULDER: () =>
          print("Controller $controllerIndex - RIGHT SHOULDER"),
      ControllerButton.LEFT_THUMB: () {
        print("Controller $controllerIndex - LEFT THUMB");
        controller.vibrate(Duration(seconds: 3));
      },
      ControllerButton.RIGHT_THUMB: () =>
          print("Controller $controllerIndex - RIGHT THUMB"),
      ControllerButton.START: () {
        controller.updateBatteryInfo();

        print("Controller $controllerIndex informations:");
        print("Type: ${controller.capababilities.type}");
        print("Subtype: ${controller.capababilities.subType}");
        print("Flags: ${controller.capababilities.flags}");
        print("Battery type: ${controller.batteryInformation.batteryType}");
        print("Battery level: ${controller.batteryInformation.batteryLevel}");

        print("============================================================");
      },
      ControllerButton.BACK: () => exit(0)
    };
    controller.variableKeysMapping = {
      VariableControllerKey.LEFT_TRIGGER: (value) =>
          print("Controller $controllerIndex - LEFT TRIGGER - $value"),
      VariableControllerKey.RIGHT_TRIGGER: (value) =>
          print("Controller $controllerIndex - RIGHT TRIGGER - $value"),
      VariableControllerKey.THUMB_LX: (value) =>
          print("Controller $controllerIndex - THUMB LX - $value"),
      VariableControllerKey.THUMB_LY: (value) =>
          print("Controller $controllerIndex - THUMB LY - $value"),
      VariableControllerKey.THUMB_RX: (value) =>
          print("Controller $controllerIndex - THUMB RX - $value"),
      VariableControllerKey.THUMB_RY: (value) =>
          print("Controller $controllerIndex - THUMB RY - $value")
    };
    controller.onReleaseButton = (button) => print("$button has ben released");

    availableControllers.add(controller);
  }

  print("Available controllers:");
  for (Controller controller in availableControllers) {
    print("Controller ${controller.index}");
  }

  for (Controller controller in availableControllers) {
    controller.lister();
  }
}
