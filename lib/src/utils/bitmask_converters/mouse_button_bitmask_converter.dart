import 'package:win32/win32.dart';
import 'package:xinput_gamepad/src/enums/mouse_button.dart';

class MouseButtonBitmaskConverter {
  static int convertButtonBitmask(MouseButton button) {
    switch (button) {
      case MouseButton.LEFT:
        return MOUSEEVENTF_LEFTDOWN;
      case MouseButton.RIGHT:
        return MOUSEEVENTF_RIGHTDOWN;
      case MouseButton.WHELL:
        return MOUSEEVENTF_MIDDLEDOWN;
    }
  }

  static int revertConvertButtonBitmask(MouseButton button) {
    switch (button) {
      case MouseButton.LEFT:
        return MOUSEEVENTF_LEFTUP;
      case MouseButton.RIGHT:
        return MOUSEEVENTF_RIGHTUP;
      case MouseButton.WHELL:
        return MOUSEEVENTF_MIDDLEUP;
    }
  }
}
