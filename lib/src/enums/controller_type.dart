// ignore_for_file: constant_identifier_names

import 'package:win32/win32.dart';
import 'package:collection/collection.dart';

///The type of the controller.
enum ControllerType {
  UNKNOWN(0),
  GAMEPAD(XINPUT_DEVTYPE_GAMEPAD);

  final int controllerTypeBitmask;

  const ControllerType(this.controllerTypeBitmask);

  factory ControllerType.fromBitmask(int bitmask) => ControllerType.values
      .firstWhereOrNull((element) => element.controllerTypeBitmask == bitmask) ?? ControllerType.UNKNOWN;
}
