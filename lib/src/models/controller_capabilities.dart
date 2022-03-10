import 'package:win32/win32.dart';
import 'package:xinput_gamepad/src/enums/controller_flags.dart';
import 'package:xinput_gamepad/src/enums/controller_subtype.dart';
import 'package:xinput_gamepad/src/enums/controller_type.dart';

class ControllerCapababilities {
  ControllerType? _type;
  ControllerType? get type {
    return _type;
  }

  late ControllerSubType _subType;
  ControllerSubType get subType {
    return _subType;
  }

  late ControllerFlags _flags;
  ControllerFlags get flags {
    return _flags;
  }

  ControllerCapababilities(XINPUT_CAPABILITIES xinputCapabilities) {
    switch (xinputCapabilities.Type) {
      case XINPUT_DEVTYPE_GAMEPAD:
        _type = ControllerType.GAMEPAD;
        break;
    }

    switch (xinputCapabilities.SubType) {
      case XINPUT_DEVSUBTYPE_UNKNOWN:
        _subType = ControllerSubType.UNKNOWN;
        break;
      case XINPUT_DEVSUBTYPE_GAMEPAD:
        _subType = ControllerSubType.GAMEPAD;
        break;
      case XINPUT_DEVSUBTYPE_WHEEL:
        _subType = ControllerSubType.WHEEL;
        break;
      case XINPUT_DEVSUBTYPE_ARCADE_STICK:
        _subType = ControllerSubType.ARCADE_STICK;
        break;
      case XINPUT_DEVSUBTYPE_FLIGHT_STICK:
        _subType = ControllerSubType.FLIGHT_STICK;
        break;
      case XINPUT_DEVSUBTYPE_DANCE_PAD:
        _subType = ControllerSubType.DANCE_PAD;
        break;
      case XINPUT_DEVSUBTYPE_GUITAR:
        _subType = ControllerSubType.GUITAR;
        break;
      case XINPUT_DEVSUBTYPE_GUITAR_ALTERNATE:
        _subType = ControllerSubType.GUITAR_ALTERNATE;
        break;
      case XINPUT_DEVSUBTYPE_DRUM_KIT:
        _subType = ControllerSubType.DRUM_KIT;
        break;
      case XINPUT_DEVSUBTYPE_GUITAR_BASS:
        _subType = ControllerSubType.GUITAR_BASS;
        break;
      case XINPUT_DEVSUBTYPE_ARCADE_PAD:
        _subType = ControllerSubType.ARCADE_PAD;
        break;
    }

    switch (xinputCapabilities.Flags) {
      case XINPUT_CAPS_VOICE_SUPPORTED:
        _flags = ControllerFlags.VOICE_SUPPORTED;
        break;
      case XINPUT_CAPS_FFB_SUPPORTED:
        _flags = ControllerFlags.FORCE_FEEDBACK_SUPPORTED;
        break;
      case XINPUT_CAPS_WIRELESS:
        _flags = ControllerFlags.WIRELESS;
        break;
      case XINPUT_CAPS_PMD_SUPPORTED:
        _flags = ControllerFlags.PLUGIN_MODULES_SUPPORTED;
        break;
      case XINPUT_CAPS_NO_NAVIGATION:
        _flags = ControllerFlags.NO_NAVIGATION;
        break;
      default:
        _flags = ControllerFlags.UNKNOWN;
        break;
    }
  }
}
