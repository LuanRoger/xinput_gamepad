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
      case 0:
        _type = ControllerType.GAMEPAD;
        break;
    }

    switch (xinputCapabilities.SubType) {
      case 0:
        _subType = ControllerSubType.UNKNOWN;
        break;
      case 1:
        _subType = ControllerSubType.GAMEPAD;
        break;
      case 2:
        _subType = ControllerSubType.WHEEL;
        break;
      case 3:
        _subType = ControllerSubType.ARCADE_STICK;
        break;
      case 4:
        _subType = ControllerSubType.FLIGHT_STICK;
        break;
      case 5:
        _subType = ControllerSubType.DANCE_PAD;
        break;
      case 6:
        _subType = ControllerSubType.GUITAR;
        break;
      case 7:
        _subType = ControllerSubType.GUITAR_ALTERNATE;
        break;
      case 8:
        _subType = ControllerSubType.DRUM_KIT;
        break;
      case 11:
        _subType = ControllerSubType.GUITAR_BASS;
        break;
      case 19:
        _subType = ControllerSubType.ARCADE_PAD;
        break;
    }

    switch (xinputCapabilities.Flags) {
      case 0:
        _flags = ControllerFlags.VOICE_SUPPORTED;
        break;
      case 1:
        _flags = ControllerFlags.FORCE_FEEDBACK_SUPPORTED;
        break;
      case 2:
        _flags = ControllerFlags.WIRELESS;
        break;
      case 3:
        _flags = ControllerFlags.PLUGIN_MODULES_SUPPORTED;
        break;
      case 4:
        _flags = ControllerFlags.NO_NAVIGATION;
        break;
      default:
        _flags = ControllerFlags.UNKNOWN;
        break;
    }
  }
}
