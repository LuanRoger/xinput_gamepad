import 'package:win32/win32.dart';
import 'package:xinput_gamepad/src/enums/controller_flag.dart';
import 'package:xinput_gamepad/src/enums/controller_subtype.dart';
import 'package:xinput_gamepad/src/enums/controller_type.dart';
import 'package:xinput_gamepad/src/utils/bitmask_converters/controller_capabilities_bitmask_converter.dart';

class ControllerCapababilities {
  late ControllerType _type;
  ///Get the type of the controller.
  ControllerType get type {
    return _type;
  }

  late ControllerSubType _subType;
  ///Get the subtype of the controller.
  ControllerSubType get subType {
    return _subType;
  }

  late ControllerFlag _flags;
  ///Get the flags that indicate the features which are supported.
  ControllerFlag get flags {
    return _flags;
  }

  ControllerCapababilities(XINPUT_CAPABILITIES xinputCapabilities) {
    _type = ControllerCapabilitiesBitmaskConverter.convertType(
        xinputCapabilities.Type);
    _subType = ControllerCapabilitiesBitmaskConverter.convertSubType(
        xinputCapabilities.SubType);
    _flags = ControllerCapabilitiesBitmaskConverter.convertFlag(
        xinputCapabilities.Flags);
  }
}
