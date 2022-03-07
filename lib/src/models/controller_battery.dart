import 'package:win32/win32.dart';
import 'package:xinput_gamepad/src/enums/battery_level.dart';
import 'package:xinput_gamepad/src/enums/battery_type.dart';

class ControllerBattery {
  late BatteryType _batteryType;
  BatteryType get batteryType {
    return _batteryType;
  }

  late BatteryLevel _batteryLevel;
  BatteryLevel get batteryLevel {
    return _batteryLevel;
  }

  ControllerBattery(XINPUT_BATTERY_INFORMATION xinputBatteryInformation) {
    switch (xinputBatteryInformation.BatteryType) {
      case 0:
        _batteryType = BatteryType.DISCONNECTED;
        break;
      case 1:
        _batteryType = BatteryType.WIRED;
        break;
      case 2:
        _batteryType = BatteryType.ALKALINE;
        break;
      case 3:
        _batteryType = BatteryType.NIMH;
        break;
      case 4:
        _batteryType = BatteryType.UNKNOWN;
        break;
    }

    switch (xinputBatteryInformation.BatteryLevel) {
      case 0:
        _batteryLevel = BatteryLevel.EMPTY;
        break;
      case 1:
        _batteryLevel = BatteryLevel.LOW;
        break;
      case 2:
        _batteryLevel = BatteryLevel.MEDIUM;
        break;
      case 3:
        _batteryLevel = BatteryLevel.FULL;
        break;
    }
  }
}
