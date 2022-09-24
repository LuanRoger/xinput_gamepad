// ignore_for_file: constant_identifier_names

import 'package:win32/win32.dart';

///Types of battery of the controller.
enum BatteryType {
  DISCONNECTED(BATTERY_TYPE_DISCONNECTED),
  WIRED(BATTERY_TYPE_WIRED),
  ALKALINE(BATTERY_TYPE_ALKALINE),
  NIMH(BATTERY_TYPE_NIMH),
  UNKNOWN(BATTERY_TYPE_UNKNOWN);

  final int batteryTypeBitmask;

  const BatteryType(this.batteryTypeBitmask);

  factory BatteryType.fromBitmask(int bitmask) => BatteryType.values[bitmask];
}
