import 'package:xinput_gamepad/xinput_gamepad.dart';

void main(List<String> arguments) {
  int positiveForce = 10;
  int negativeForce = -10;

  XInputManager.enableXInput();

  List<Controller> availableControllers = List.empty(growable: true);

  for (int controllerIndex in XInputManager.getIndexConnectedControllers()) {
    Controller controller = Controller(index: controllerIndex);
    controller.variableKeysMapping = {
      VariableControllerKey.THUMB_LX: (value) {
        if (value == 0) return;
        int force = value > 0 ? positiveForce : negativeForce;

        VirtualCursor.setForce(force, MouseAxis.X, MouseVariableButton.CURSOR);
        print("Controller $controllerIndex - Set force in cursor in X axis");
      },
      VariableControllerKey.THUMB_LY: (value) {
        if (value == 0) return;
        int force = value > 0 ? negativeForce : positiveForce;

        VirtualCursor.setForce(force, MouseAxis.Y, MouseVariableButton.CURSOR);
        print("Controller $controllerIndex - Set force in cursor in Y axis");
      },
      VariableControllerKey.THUMB_RX: ((value) {
        if (value == 0) return;
        int force = value > 0 ? positiveForce : negativeForce;

        VirtualCursor.setForce(force, MouseAxis.X, MouseVariableButton.WHEEL);
        print("Controller $controllerIndex - Set force in wheel in X axis");
      }),
      VariableControllerKey.THUMB_RY: ((value) {
        if (value == 0) return;
        int force = value > 0 ? positiveForce : negativeForce;

        VirtualCursor.setForce(force, MouseAxis.Y, MouseVariableButton.WHEEL);
        print("Controller $controllerIndex - Set force in wheel in Y axis");
      })
    };
    controller.buttonsMapping = {
      ControllerButton.A_BUTTON: () {
        VirtualCursor.press(MouseButton.LEFT);
        print("Controller $controllerIndex - Press left mouse button");
      },
      ControllerButton.B_BUTTON: () {
        VirtualCursor.press(MouseButton.RIGHT);
        print("Controller $controllerIndex - Press right mouse button");
      },
      ControllerButton.RIGHT_THUMB: () {
        VirtualCursor.press(MouseButton.WHEEL);
        print("Controller $controllerIndex - Press wheel mouse button");
      }
    };

    availableControllers.add(controller);
  }

  print("Available Controllers:");
  for (Controller controller in availableControllers) {
    print("Controller ${controller.index}");
    controller.lister();
  }
}
