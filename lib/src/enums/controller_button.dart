// ignore_for_file: constant_identifier_names
import 'package:win32/win32.dart';

///Buttons of the controller (Xbox model).
enum ControllerButton {
  DPAD_UP(XINPUT_GAMEPAD_DPAD_UP),
  DPAD_DOWN(XINPUT_GAMEPAD_DPAD_DOWN),
  DPAD_LEFT(XINPUT_GAMEPAD_DPAD_LEFT),
  DPAD_RIGHT(XINPUT_GAMEPAD_DPAD_RIGHT),
  START(XINPUT_GAMEPAD_START),
  BACK(XINPUT_GAMEPAD_BACK),
  LEFT_THUMB(XINPUT_GAMEPAD_LEFT_THUMB),
  RIGHT_THUMB(XINPUT_GAMEPAD_RIGHT_THUMB),
  LEFT_SHOULDER(XINPUT_GAMEPAD_LEFT_SHOULDER),
  RIGHT_SHOULDER(XINPUT_GAMEPAD_RIGHT_SHOULDER),
  A_BUTTON(XINPUT_GAMEPAD_A),
  B_BUTTON(XINPUT_GAMEPAD_B),
  X_BUTTON(XINPUT_GAMEPAD_X),
  Y_BUTTON(XINPUT_GAMEPAD_Y);

  final int buttonBitmask;

  const ControllerButton(this.buttonBitmask);

  static List<ControllerButton>? convertFromBitmask(int bitmask) {
    List<ControllerButton>? buttons = List.empty(growable: true);

    if (bitmask & ControllerButton.DPAD_UP.buttonBitmask > 0) {
      buttons.add(ControllerButton.DPAD_UP);
    }
    if (bitmask & ControllerButton.DPAD_DOWN.buttonBitmask > 0) {
      buttons.add(ControllerButton.DPAD_DOWN);
    }
    if (bitmask & ControllerButton.DPAD_LEFT.buttonBitmask > 0) {
      buttons.add(ControllerButton.DPAD_LEFT);
    }
    if (bitmask & ControllerButton.DPAD_RIGHT.buttonBitmask > 0) {
      buttons.add(ControllerButton.DPAD_RIGHT);
    }
    if (bitmask & ControllerButton.START.buttonBitmask > 0) {
      buttons.add(ControllerButton.START);
    }
    if (bitmask & ControllerButton.BACK.buttonBitmask > 0) {
      buttons.add(ControllerButton.BACK);
    }
    if (bitmask & ControllerButton.LEFT_THUMB.buttonBitmask > 0) {
      buttons.add(ControllerButton.LEFT_THUMB);
    }
    if (bitmask & ControllerButton.RIGHT_THUMB.buttonBitmask > 0) {
      buttons.add(ControllerButton.RIGHT_THUMB);
    }
    if (bitmask & ControllerButton.LEFT_SHOULDER.buttonBitmask > 0) {
      buttons.add(ControllerButton.LEFT_SHOULDER);
    }
    if (bitmask & ControllerButton.RIGHT_SHOULDER.buttonBitmask > 0) {
      buttons.add(ControllerButton.RIGHT_SHOULDER);
    }
    if (bitmask & ControllerButton.A_BUTTON.buttonBitmask > 0) {
      buttons.add(ControllerButton.A_BUTTON);
    }
    if (bitmask & ControllerButton.B_BUTTON.buttonBitmask > 0) {
      buttons.add(ControllerButton.B_BUTTON);
    }
    if (bitmask & ControllerButton.X_BUTTON.buttonBitmask > 0) {
      buttons.add(ControllerButton.X_BUTTON);
    }
    if (bitmask & ControllerButton.Y_BUTTON.buttonBitmask > 0) {
      buttons.add(ControllerButton.Y_BUTTON);
    }

    return buttons.isNotEmpty ? buttons : null;
  }
}
