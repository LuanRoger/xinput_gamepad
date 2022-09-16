import 'package:win32/win32.dart';
import 'package:xinput_gamepad/src/enums/battery_level.dart';
import 'package:xinput_gamepad/src/enums/battery_type.dart';
import 'package:xinput_gamepad/src/utils/bitmask_converters/controller_battery_bitmask_converter.dart';

///Information of controller's battery.
class ControllerBattery {
  late BatteryType _batteryType;

  ///Get the type of the battery.
  BatteryType get batteryType {
    return _batteryType;
  }

  late BatteryLevel _batteryLevel;

  ///Get the level of the battery.
  BatteryLevel get batteryLevel {
    return _batteryLevel;
  }

  ControllerBattery(XINPUT_BATTERY_INFORMATION xinputBatteryInformation) {
    _batteryType = ControllerBatteryBitmaskConverter.convertBatteryType(
        xinputBatteryInformation.BatteryType);

    _batteryLevel = ControllerBatteryBitmaskConverter.convertBatteryLevel(
        xinputBatteryInformation.BatteryLevel);
  }
}
