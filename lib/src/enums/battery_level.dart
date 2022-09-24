// ignore_for_file: constant_identifier_names

import 'package:win32/win32.dart';

///Controller's battery levels.
enum BatteryLevel {
  EMPTY(BATTERY_LEVEL_EMPTY),
  LOW(BATTERY_LEVEL_LOW),
  MEDIUM(BATTERY_LEVEL_MEDIUM),
  FULL(BATTERY_LEVEL_FULL);

  final int batteryBitmask;

  const BatteryLevel(this.batteryBitmask);

  factory BatteryLevel.fromBitmask(int bitmask) => BatteryLevel.values
      .firstWhere((element) => element.batteryBitmask == bitmask);
}
