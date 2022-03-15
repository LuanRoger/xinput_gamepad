import 'package:flutter/cupertino.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class HomePageController extends ChangeNotifier {
  KeyboardKey aButton;
  KeyboardKey bButton;
  KeyboardKey xButton;
  KeyboardKey yButton;
  KeyboardKey dUpButton;
  KeyboardKey dDownButton;
  KeyboardKey dLeftButton;
  KeyboardKey dRightButton;
  KeyboardKey startButton;
  KeyboardKey backButton;
  KeyboardKey leftThumbButton;
  KeyboardKey rightThumbButton;
  KeyboardKey leftShoulderButton;
  KeyboardKey rightSholderButton;

  late Controller controller;
  void initController({int index = 0}) {
    controller = Controller(index: index, buttonMode: ButtonMode.HOLD, buttonsMapping: {
      ControllerButton.A_BUTTON: () => VirtualKeyboard.press(aButton),
      ControllerButton.B_BUTTON: () => VirtualKeyboard.press(bButton),
      ControllerButton.X_BUTTON: () => VirtualKeyboard.press(xButton),
      ControllerButton.Y_BUTTON: () => VirtualKeyboard.press(yButton),
      ControllerButton.DPAD_UP: () => VirtualKeyboard.press(dUpButton),
      ControllerButton.DPAD_DOWN: () => VirtualKeyboard.press(dDownButton),
      ControllerButton.DPAD_LEFT: () => VirtualKeyboard.press(dLeftButton),
      ControllerButton.DPAD_RIGHT: () => VirtualKeyboard.press(dRightButton),
      ControllerButton.START: () => VirtualKeyboard.press(startButton),
      ControllerButton.BACK: () => VirtualKeyboard.press(backButton),
      ControllerButton.LEFT_THUMB: () => VirtualKeyboard.press(leftThumbButton),
      ControllerButton.RIGHT_THUMB: () =>
          VirtualKeyboard.press(rightSholderButton),
      ControllerButton.LEFT_SHOULDER: () =>
          VirtualKeyboard.press(leftShoulderButton),
      ControllerButton.RIGHT_SHOULDER: () =>
          VirtualKeyboard.press(rightSholderButton),
    });
    controller.lister();
  }

  HomePageController(
      {this.aButton = KeyboardKey.A,
      this.bButton = KeyboardKey.B,
      this.xButton = KeyboardKey.X,
      this.yButton = KeyboardKey.Y,
      this.dUpButton = KeyboardKey.UP_ARROW,
      this.dDownButton = KeyboardKey.DOWN_ARROW,
      this.dLeftButton = KeyboardKey.LEFT_ARROW,
      this.dRightButton = KeyboardKey.RIGHT_ARROW,
      this.startButton = KeyboardKey.L_WIN,
      this.backButton = KeyboardKey.TAB,
      this.leftThumbButton = KeyboardKey.PRINT_SCREEN,
      this.rightThumbButton = KeyboardKey.CAPS_LOCK,
      this.leftShoulderButton = KeyboardKey.BACKSPACE,
      this.rightSholderButton = KeyboardKey.SPACE}) {
    initController();
  }

  TextEditingController textFieldController = TextEditingController();

  KeyboardKey getButtonValue(ControllerButton button) {
    switch (button) {
      case ControllerButton.A_BUTTON:
        return aButton;
      case ControllerButton.B_BUTTON:
        return bButton;
      case ControllerButton.X_BUTTON:
        return xButton;
      case ControllerButton.Y_BUTTON:
        return yButton;
      case ControllerButton.DPAD_UP:
        return dUpButton;
      case ControllerButton.DPAD_DOWN:
        return dDownButton;
      case ControllerButton.DPAD_LEFT:
        return dLeftButton;
      case ControllerButton.DPAD_RIGHT:
        return dRightButton;
      case ControllerButton.START:
        return startButton;
      case ControllerButton.BACK:
        return backButton;
      case ControllerButton.LEFT_THUMB:
        return leftThumbButton;
      case ControllerButton.RIGHT_THUMB:
        return rightThumbButton;
      case ControllerButton.LEFT_SHOULDER:
        return leftShoulderButton;
      case ControllerButton.RIGHT_SHOULDER:
        return rightSholderButton;
    }
  }

  void changeButtonMapping(ControllerButton button, KeyboardKey newKey) {
    switch (button) {
      case ControllerButton.A_BUTTON:
        aButton = newKey;
        break;
      case ControllerButton.B_BUTTON:
        bButton = newKey;
        break;
      case ControllerButton.X_BUTTON:
        xButton = newKey;
        break;
      case ControllerButton.Y_BUTTON:
        yButton = newKey;
        break;
      case ControllerButton.DPAD_UP:
        dUpButton = newKey;
        break;
      case ControllerButton.DPAD_DOWN:
        dDownButton = newKey;
        break;
      case ControllerButton.DPAD_LEFT:
        dLeftButton = newKey;
        break;
      case ControllerButton.DPAD_RIGHT:
        dRightButton = newKey;
        break;
      case ControllerButton.START:
        startButton = newKey;
        break;
      case ControllerButton.BACK:
        backButton = newKey;
        break;
      case ControllerButton.LEFT_THUMB:
        leftThumbButton = newKey;
        break;
      case ControllerButton.RIGHT_THUMB:
        rightThumbButton = newKey;
        break;
      case ControllerButton.LEFT_SHOULDER:
        leftShoulderButton = newKey;
        break;
      case ControllerButton.RIGHT_SHOULDER:
        rightSholderButton = newKey;
        break;
    }

    notifyListeners();
  }

  void changeControllerIndex(int index) {
    initController(index: index);
    notifyListeners();
  }
}
