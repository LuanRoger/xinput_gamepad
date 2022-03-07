import 'package:xinput_gamepad/src/enums/controller_button.dart';

class InputUtils {
  static ControllerButton? getButtonByBitmask(int bitmask) {
    ControllerButton? button;

    switch (bitmask) {
      case 1:
        button = ControllerButton.DPAD_UP;
        break;
      case 2:
        button = ControllerButton.DPAD_DOWN;
        break;
      case 4:
        button = ControllerButton.DPAD_LEFT;
        break;
      case 8:
        button = ControllerButton.DPAD_RIGHT;
        break;
      case 16:
        button = ControllerButton.START;
        break;
      case 32:
        button = ControllerButton.BACK;
        break;
      case 64:
        button = ControllerButton.LEFT_THUMB;
        break;
      case 128:
        button = ControllerButton.RIGHT_THUMB;
        break;
      case 256:
        button = ControllerButton.LEFT_SHOULDER;
        break;
      case 512:
        button = ControllerButton.RIGHT_SHOULDER;
        break;
      case 4096:
        button = ControllerButton.A_BUTTON;
        break;
      case 8192:
        button = ControllerButton.B_BUTTON;
        break;
      case 16384:
        button = ControllerButton.X_BUTTON;
        break;
      case 32768:
        button = ControllerButton.Y_BUTTON;
        break;
      default:
        button = null;
    }

    return button;
  }
}
