import 'package:xinput_gamepad/src/utils/controller_utils.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';
import 'package:xinput_gamepad/src/gamepad/controller.dart';

class ControllersManager {
  List<Controller> controllers;

  ControllersManager(this.controllers);

  factory ControllersManager.getAllControllers() {
    List<int> connectedControllers =
        ControllerUtils.getIndexConnectedControllers();

    List<Controller> controllers = List.empty(growable: true);
    for (int controllerIndex in connectedControllers) {
      controllers.add(Controller(index: controllerIndex));
    }

    return ControllersManager(controllers);
  }

  void disableAll() {
    for (Controller controller in controllers) {
      controller.activated = false;
    }
  }

  void enableAll() {
    for (Controller controller in controllers) {
      controller.activated = true;
    }
  }

  void vibrateAll(Duration duration) {
    for (Controller controller in controllers) {
      controller.vibrate(duration);
    }
  }
}
