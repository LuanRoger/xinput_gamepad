import 'package:win32/win32.dart';
import 'package:xinput_gamepad/src/utils/controller_utils.dart';

class XInputManager {
  static int inputLag = 30; //In miliseconds

  static void enableXInput() => XInputEnable(TRUE);
  static void disableXInput() => XInputEnable(FALSE);

  static void uninitialize() => CoUninitialize();

  static List<int> getIndexConnectedControllers() =>
      ControllerUtils.getIndexConnectedControllers();
}
