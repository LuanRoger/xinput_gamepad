import 'package:ffi/ffi.dart';
import 'dart:ffi';
import 'package:win32/win32.dart';
import 'package:xinput_gamepad/src/enums/mouse_axis.dart';
import 'package:xinput_gamepad/src/enums/mouse_button.dart';
import 'package:xinput_gamepad/src/enums/mouse_variable_button.dart';
import 'package:xinput_gamepad/src/utils/bitmask_converters/mouse_button_bitmask_converter.dart';

///Simulate a mouse/cursor inputs and movements.
class VirtualCursor {
  ///Set force to a variable mouse button.
  ///```force``` - Amount of the movement.
  ///```axis``` - Axis of the movement.
  ///```button``` - Mouse variable button that will be affected by the force.
  static void setForce(int force, MouseAxis axis, MouseVariableButton button) {
    Pointer<INPUT> input = calloc<INPUT>();
    ZeroMemory(input, sizeOf<INPUT>());

    input.ref.type = INPUT_MOUSE;
    switch (button) {
      case MouseVariableButton.CURSOR:
        input.ref.mi.dwFlags = MOUSEEVENTF_MOVE;
        switch (axis) {
          case MouseAxis.X:
            input.ref.mi.dx = force;
            break;
          case MouseAxis.Y:
            input.ref.mi.dy = force;
            break;
        }
        break;
      case MouseVariableButton.WHEEL:
        input.ref.mi.dwFlags =
            axis == MouseAxis.Y ? MOUSEEVENTF_WHEEL : MOUSEEVENTF_HWHEEL;
        input.ref.mi.mouseData = force;
        break;
    }

    SendInput(INPUT_KEYBOARD, input, sizeOf<INPUT>());

    free(input);
  }

  ///Simulate a press and release in a mouse button.
  ///```button``` - Mouse button.
  static void press(MouseButton button) {
    Pointer<INPUT> input = calloc<INPUT>();
    ZeroMemory(input, sizeOf<INPUT>());

    input.ref.type = INPUT_MOUSE;
    input.ref.mi.dwFlags =
        MouseButtonBitmaskConverter.convertButtonBitmask(button);

    SendInput(INPUT_HARDWARE, input, sizeOf<INPUT>());

    input.ref.mi.dwFlags =
        MouseButtonBitmaskConverter.revertConvertButtonBitmask(button);
    SendInput(INPUT_HARDWARE, input, sizeOf<INPUT>());

    free(input);
  }
}
