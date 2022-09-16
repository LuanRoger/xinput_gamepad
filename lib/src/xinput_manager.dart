import 'package:win32/win32.dart';

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
}
