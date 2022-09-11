import 'package:win32/win32.dart';
import 'package:xinput_gamepad/src/enums/controller_button.dart';

class InputBitmaskConverter {
  static List<ControllerButton>? convertButton(int bitmask) {
    List<ControllerButton>? buttons = List.empty(growable: true);

    if (bitmask & XINPUT_GAMEPAD_DPAD_UP > 0) {
      buttons.add(ControllerButton.DPAD_UP);
    }
    if (bitmask & XINPUT_GAMEPAD_DPAD_DOWN > 0) {
      buttons.add(ControllerButton.DPAD_DOWN);
    }
    if (bitmask & XINPUT_GAMEPAD_DPAD_LEFT > 0) {
      buttons.add(ControllerButton.DPAD_LEFT);
    }
    if (bitmask & XINPUT_GAMEPAD_DPAD_RIGHT > 0) {
      buttons.add(ControllerButton.DPAD_RIGHT);
    }
    if (bitmask & XINPUT_GAMEPAD_START > 0) {
      buttons.add(ControllerButton.START);
    }
    if (bitmask & XINPUT_GAMEPAD_BACK > 0) {
      buttons.add(ControllerButton.BACK);
    }
    if (bitmask & XINPUT_GAMEPAD_LEFT_THUMB > 0) {
      buttons.add(ControllerButton.LEFT_THUMB);
    }
    if (bitmask & XINPUT_GAMEPAD_RIGHT_THUMB > 0) {
      buttons.add(ControllerButton.RIGHT_THUMB);
    }
    if (bitmask & XINPUT_GAMEPAD_LEFT_SHOULDER > 0) {
      buttons.add(ControllerButton.LEFT_SHOULDER);
    }
    if (bitmask & XINPUT_GAMEPAD_RIGHT_SHOULDER > 0) {
      buttons.add(ControllerButton.RIGHT_SHOULDER);
    }
    if (bitmask & XINPUT_GAMEPAD_A > 0) {
      buttons.add(ControllerButton.A_BUTTON);
    }
    if (bitmask & XINPUT_GAMEPAD_B > 0) {
      buttons.add(ControllerButton.B_BUTTON);
    }
    if (bitmask & XINPUT_GAMEPAD_X > 0) {
      buttons.add(ControllerButton.X_BUTTON);
    }
    if (bitmask & XINPUT_GAMEPAD_Y > 0) {
      buttons.add(ControllerButton.Y_BUTTON);
    }

    return buttons.isNotEmpty ? buttons : null;
  }
}
