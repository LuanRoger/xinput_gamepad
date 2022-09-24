// ignore_for_file: constant_identifier_names

import 'package:win32/win32.dart';

///The type of the controller.
enum ControllerType {
  GAMEPAD(XINPUT_DEVTYPE_GAMEPAD);

  final int controllerTypeBitmask;

  const ControllerType(this.controllerTypeBitmask);

  factory ControllerType.fromBitmask(int bitmask) => ControllerType.values
      .firstWhere((element) => element.controllerTypeBitmask == bitmask);
}
