import 'package:win32/win32.dart';
import 'package:xinput_gamepad/src/enums/battery_level.dart';
import 'package:xinput_gamepad/src/enums/battery_type.dart';

///Information of controller's battery.
class ControllerBattery {
  late final BatteryType _batteryType;

  ///Get the type of the battery.
  BatteryType get batteryType {
    return _batteryType;
  }

  late final BatteryLevel _batteryLevel;

  ///Get the level of the battery.
  BatteryLevel get batteryLevel {
    return _batteryLevel;
  }

  ControllerBattery(XINPUT_BATTERY_INFORMATION xinputBatteryInformation) {
    _batteryType =
        BatteryType.fromBitmask(xinputBatteryInformation.BatteryType);

    _batteryLevel =
        BatteryLevel.fromBitmask(xinputBatteryInformation.BatteryLevel);
  }
}
