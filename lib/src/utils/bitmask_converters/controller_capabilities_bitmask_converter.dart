import 'package:win32/win32.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ControllerCapabilitiesBitmaskConverter {
  static ControllerType convertType(int bitmask) {
    switch (bitmask) {
      case XINPUT_DEVTYPE_GAMEPAD:
        return ControllerType.GAMEPAD;
      default:
        return ControllerType.UNKNOWN;
    }
  }
  static ControllerSubType convertSubType(int bitmask) {
    switch (bitmask) {
      case XINPUT_DEVSUBTYPE_GAMEPAD:
        return ControllerSubType.GAMEPAD;
      case XINPUT_DEVSUBTYPE_WHEEL:
        return ControllerSubType.WHEEL;
      case XINPUT_DEVSUBTYPE_ARCADE_STICK:
        return ControllerSubType.ARCADE_STICK;
      case XINPUT_DEVSUBTYPE_FLIGHT_STICK:
        return ControllerSubType.FLIGHT_STICK;
      case XINPUT_DEVSUBTYPE_DANCE_PAD:
        return ControllerSubType.DANCE_PAD;
      case XINPUT_DEVSUBTYPE_GUITAR:
        return ControllerSubType.GUITAR;
      case XINPUT_DEVSUBTYPE_GUITAR_ALTERNATE:
        return ControllerSubType.GUITAR_ALTERNATE;
      case XINPUT_DEVSUBTYPE_DRUM_KIT:
        return ControllerSubType.DRUM_KIT;
      case XINPUT_DEVSUBTYPE_GUITAR_BASS:
        return ControllerSubType.GUITAR_BASS;
      case XINPUT_DEVSUBTYPE_ARCADE_PAD:
        return ControllerSubType.ARCADE_PAD;
      case XINPUT_DEVSUBTYPE_UNKNOWN:
      default:
        return ControllerSubType.UNKNOWN;
    }
  }
  static ControllerFlags convertFlag(int bitmask) {
    switch (bitmask) {
      case XINPUT_CAPS_VOICE_SUPPORTED:
        return ControllerFlags.VOICE_SUPPORTED;
      case XINPUT_CAPS_FFB_SUPPORTED:
        return ControllerFlags.FORCE_FEEDBACK_SUPPORTED;
      case XINPUT_CAPS_WIRELESS:
        return ControllerFlags.WIRELESS;
      case XINPUT_CAPS_PMD_SUPPORTED:
        return ControllerFlags.PLUGIN_MODULES_SUPPORTED;
      case XINPUT_CAPS_NO_NAVIGATION:
        return ControllerFlags.NO_NAVIGATION;
      default:
        return ControllerFlags.UNKNOWN;
    }
  }
}
