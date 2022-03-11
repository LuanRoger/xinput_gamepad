import 'package:win32/win32.dart';
import 'package:xinput_gamepad/src/enums/battery_level.dart';
import 'package:xinput_gamepad/src/enums/battery_type.dart';

class ControllerBatteryBitmaskConverter {
  static BatteryType convertBatteryType(int bitmask) {
    switch (bitmask) {
      case BATTERY_TYPE_DISCONNECTED:
        return BatteryType.DISCONNECTED;
      case BATTERY_TYPE_WIRED:
        return BatteryType.WIRED;
      case BATTERY_TYPE_ALKALINE:
        return BatteryType.ALKALINE;
      case BATTERY_TYPE_NIMH:
        return BatteryType.NIMH;
      case BATTERY_TYPE_UNKNOWN:
      default:
        return BatteryType.UNKNOWN;
    }
  }

  static BatteryLevel convertBatteryLevel(int bitmask) {
    switch (bitmask) {
      case BATTERY_LEVEL_EMPTY:
        return BatteryLevel.EMPTY;
      case BATTERY_LEVEL_LOW:
        return BatteryLevel.LOW;
      case BATTERY_LEVEL_MEDIUM:
        return BatteryLevel.MEDIUM;
      case BATTERY_LEVEL_FULL:
        return BatteryLevel.FULL;
      default:
        return BatteryLevel.UNKNOWN;
    }
  }
}
