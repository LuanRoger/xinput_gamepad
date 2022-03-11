import 'package:win32/win32.dart';
import 'package:xinput_gamepad/src/enums/controller_button.dart';

class InputBitmaskConverter {
  static ControllerButton? convertButton(int bitmask) {
    ControllerButton? button;

    switch (bitmask) {
      case XINPUT_GAMEPAD_DPAD_UP:
        button = ControllerButton.DPAD_UP;
        break;
      case XINPUT_GAMEPAD_DPAD_DOWN:
        button = ControllerButton.DPAD_DOWN;
        break;
      case XINPUT_GAMEPAD_DPAD_LEFT:
        button = ControllerButton.DPAD_LEFT;
        break;
      case XINPUT_GAMEPAD_DPAD_RIGHT:
        button = ControllerButton.DPAD_RIGHT;
        break;
      case XINPUT_GAMEPAD_START:
        button = ControllerButton.START;
        break;
      case XINPUT_GAMEPAD_BACK:
        button = ControllerButton.BACK;
        break;
      case XINPUT_GAMEPAD_LEFT_THUMB:
        button = ControllerButton.LEFT_THUMB;
        break;
      case XINPUT_GAMEPAD_RIGHT_THUMB:
        button = ControllerButton.RIGHT_THUMB;
        break;
      case XINPUT_GAMEPAD_LEFT_SHOULDER:
        button = ControllerButton.LEFT_SHOULDER;
        break;
      case XINPUT_GAMEPAD_RIGHT_SHOULDER:
        button = ControllerButton.RIGHT_SHOULDER;
        break;
      case XINPUT_GAMEPAD_A:
        button = ControllerButton.A_BUTTON;
        break;
      case XINPUT_GAMEPAD_B:
        button = ControllerButton.B_BUTTON;
        break;
      case XINPUT_GAMEPAD_X:
        button = ControllerButton.X_BUTTON;
        break;
      case XINPUT_GAMEPAD_Y:
        button = ControllerButton.Y_BUTTON;
        break;
      default:
        button = null;
    }

    return button;
  }
}
