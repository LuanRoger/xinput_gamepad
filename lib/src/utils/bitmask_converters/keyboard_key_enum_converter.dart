import 'package:win32/win32.dart';
import 'package:xinput_gamepad/src/enums/keyboard_key.dart';

class KeyboardKeyEnumConverter {
  static int convertKeyboardKey(KeyboardKey keyCode) {
    switch (keyCode) {
      case KeyboardKey.A:
        return 65;
      case KeyboardKey.B:
        return 66;
      case KeyboardKey.C:
        return 67;
    }
  }
}
