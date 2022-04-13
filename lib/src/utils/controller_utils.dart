import 'dart:ffi';
import 'package:win32/win32.dart';
import 'package:ffi/ffi.dart';
import 'package:xinput_gamepad/src/xinput_manager.dart';

class ControllerUtils {
  static List<int> getIndexConnectedControllers() {
    final state = calloc<XINPUT_STATE>();
    final List<int> connectedControllersIndex = List.empty(growable: true);

    for (int controllerIndex = 0;
        controllerIndex < XUSER_MAX_COUNT;
        controllerIndex++) {
      final dwRewuslt = XInputGetState(controllerIndex, state);

      if (dwRewuslt == ERROR_SUCCESS) {
        connectedControllersIndex.add(controllerIndex);
      }
    }

    free(state);
    CoUninitialize();

    return connectedControllersIndex;
  }

  static bool isConnected(int controllerIndex) {
    final state = calloc<XINPUT_STATE>();

    final dwState = XInputGetState(controllerIndex, state);

    bool isConnected = dwState == ERROR_SUCCESS;

    free(state);
    CoUninitialize();

    return isConnected;
  }

  static Pointer<XINPUT_CAPABILITIES> getCapabilities(int controllerIndex) {
    final capabilities = calloc<XINPUT_CAPABILITIES>();
    XInputGetCapabilities(controllerIndex, 0, capabilities);

    return capabilities;
  }
  static Pointer<XINPUT_BATTERY_INFORMATION> getBatteryInformation(
      int controllerIndex) {
    final batteryInformation = calloc<XINPUT_BATTERY_INFORMATION>();
    XInputGetBatteryInformation(controllerIndex, 0, batteryInformation);

    return batteryInformation;
  }

  static Stream<Pointer<XINPUT_STATE>> streamState(int controllerIndex) async* {
    while (true) {
      final state = calloc<XINPUT_STATE>();
      XInputGetState(controllerIndex, state);

      await Future.delayed(Duration(milliseconds: XInputManager.inputLag));

      yield state;
    }
  }
}
