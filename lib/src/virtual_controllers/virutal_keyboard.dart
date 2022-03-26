import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';
import 'package:xinput_gamepad/src/enums/keyboard_key.dart';
import 'package:xinput_gamepad/src/utils/bitmask_converters/keyboard_key_enum_converter.dart';

class VirtualKeyboard {
  static void press(KeyboardKey keyInput) {
    Pointer<INPUT> input = calloc<INPUT>();
    ZeroMemory(input, sizeOf<INPUT>());

    input.ref.type = INPUT_KEYBOARD;
    int? virtualKeyMask = KeyboardKeyEnumConverter.convertKeyboardKey(keyInput);
    if (virtualKeyMask == null) return;

    input.ref.ki.wVk = virtualKeyMask;

    SendInput(INPUT_KEYBOARD, input, sizeOf<INPUT>());

    //Release button
    input.ref.ki.dwFlags = KEYEVENTF_KEYUP;
    SendInput(INPUT_KEYBOARD, input, sizeOf<INPUT>());

    free(input);
  }
}
