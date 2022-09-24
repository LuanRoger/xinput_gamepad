import 'package:win32/win32.dart';
import 'package:xinput_gamepad/src/enums/controller_flag.dart';
import 'package:xinput_gamepad/src/enums/controller_subtype.dart';
import 'package:xinput_gamepad/src/enums/controller_type.dart';

class ControllerCapababilities {
  late final ControllerType _type;

  ///Get the type of the controller.
  ControllerType get type {
    return _type;
  }

  late final ControllerSubType _subType;

  ///Get the subtype of the controller.
  ControllerSubType get subType {
    return _subType;
  }

  late final ControllerFlag _flags;

  ///Get the flags that indicate the features which are supported.
  ControllerFlag get flags {
    return _flags;
  }

  ControllerCapababilities(XINPUT_CAPABILITIES xinputCapabilities) {
    _type = ControllerType.fromBitmask(xinputCapabilities.Type);
    _subType = ControllerSubType.fromBitmask(xinputCapabilities.SubType);
    _flags = ControllerFlag.fromBitmask(xinputCapabilities.Flags);
  }
}
