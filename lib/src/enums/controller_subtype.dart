// ignore_for_file: constant_identifier_names

import 'package:win32/win32.dart';
import 'package:collection/collection.dart';

///Subtype of the controller.
///See more: https://docs.microsoft.com/en-us/windows/win32/xinput/xinput-and-controller-subtypes
enum ControllerSubType {
  UNKNOWN(XINPUT_DEVSUBTYPE_UNKNOWN),
  GAMEPAD(XINPUT_DEVSUBTYPE_GAMEPAD),
  WHEEL(XINPUT_DEVSUBTYPE_WHEEL),
  ARCADE_STICK(XINPUT_DEVSUBTYPE_ARCADE_STICK),
  FLIGHT_STICK(XINPUT_DEVSUBTYPE_FLIGHT_STICK),
  DANCE_PAD(XINPUT_DEVSUBTYPE_DANCE_PAD),
  GUITAR(XINPUT_DEVSUBTYPE_GUITAR),
  GUITAR_ALTERNATE(XINPUT_DEVSUBTYPE_GUITAR_ALTERNATE),
  DRUM_KIT(XINPUT_DEVSUBTYPE_DRUM_KIT),
  GUITAR_BASS(XINPUT_DEVSUBTYPE_GUITAR_BASS),
  ARCADE_PAD(XINPUT_DEVSUBTYPE_ARCADE_PAD);

  final int subTypeBitmask;

  const ControllerSubType(this.subTypeBitmask);

  factory ControllerSubType.fromBitmask(int bitmask) => ControllerSubType.values
      .firstWhereOrNull((element) => element.subTypeBitmask == bitmask) ?? ControllerSubType.UNKNOWN;
}
