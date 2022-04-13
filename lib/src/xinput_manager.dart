import 'package:win32/win32.dart';
import 'package:xinput_gamepad/src/utils/controller_utils.dart';

///Manager of the XInput library.
class XInputManager {
  ///Set a input lag to all controllers in miliseconds.
  static int inputLag = 30;

  ///Enable XInput.
  static void enableXInput() => XInputEnable(TRUE);

  ///Disable XInput.
  static void disableXInput() => XInputEnable(FALSE);
  ///Closes the COM library on the current thread,
  ///unloads all DLLs loaded by the thread,
  ///frees any other resources that the thread maintains.
  static void uninitialize() => CoUninitialize();

  ///Get the index of all connected controllers.
  static List<int> getIndexConnectedControllers() =>
      ControllerUtils.getIndexConnectedControllers();
}
