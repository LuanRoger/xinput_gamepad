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

  //TODO: Implement
  void disableAll() {}
  void enableAll() {}
  void vibrateAll() {}
}
