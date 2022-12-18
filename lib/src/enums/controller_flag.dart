// ignore_for_file: constant_identifier_names

import 'package:win32/win32.dart';
import 'package:collection/collection.dart';

///Flags that indicate the features which are supported.
///
///UNKNOWN - Is unknown.
///
///VOICE_SUPPORTED - Device has an integrated voice device.
///
///FORCE_FEEDBACK_SUPPORTED - Device supports force feedback functionality. Note that these force-feedback features beyond rumble are not currently supported through XINPUT on Windows.
///
///WIRELESS - Device is wireless.
///
///PLUGIN_MODULES_SUPPORTED -	Device supports plug-in modules. Note that plug-in modules like the text input device (TID) are not supported currently through XINPUT on Windows.
///
///NO_NAVIGATION - Device lacks menu navigation buttons (START, BACK, DPAD).
enum ControllerFlag {
  VOICE_SUPPORTED(XINPUT_CAPS_VOICE_SUPPORTED),
  FORCE_FEEDBACK_SUPPORTED(XINPUT_CAPS_FFB_SUPPORTED),
  WIRELESS(XINPUT_CAPS_WIRELESS),
  PLUGIN_MODULES_SUPPORTED(XINPUT_CAPS_PMD_SUPPORTED),
  NO_NAVIGATION(XINPUT_CAPS_NO_NAVIGATION),
  UNKNOWN(0);

  final int flagBitmask;

  const ControllerFlag(this.flagBitmask);

  factory ControllerFlag.fromBitmask(int bitmask) => ControllerFlag.values
          .firstWhereOrNull((element) => element.flagBitmask == bitmask) ?? 
          ControllerFlag.UNKNOWN;
}
