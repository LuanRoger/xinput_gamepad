import 'package:xinput_gamepad/src/utils/controller_utils.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';
import 'package:xinput_gamepad/src/gamepad/controller.dart';

///Manage multiple controls simultaneously.
class ControllersManager {
  ///List of controller than will affected by the manager.
  List<Controller> controllers;

  ///Instatiate a new ```ControllersManager```.
  ControllersManager(this.controllers);

  ///Instatiate a new ```ControllersManager``` with all connected controllers has added.
  factory ControllersManager.getAllControllers() {
    List<int> connectedControllers =
        ControllerUtils.getIndexConnectedControllers();

    List<Controller> controllers = List.empty(growable: true);
    for (int controllerIndex in connectedControllers) {
      controllers.add(Controller(index: controllerIndex));
    }

    return ControllersManager(controllers);
  }

  ///Disable all controllers.
  void disableAll() {
    for (Controller controller in controllers) {
      controller.activated = false;
    }
  }
  ///Enable all controllers.
  void enableAll() {
    for (Controller controller in controllers) {
      controller.activated = true;
    }
  }

  ///Vibrate all controllers at same time.
  void vibrateAll(Duration duration) {
    for (Controller controller in controllers) {
      controller.vibrate(duration);
    }
  }
}
