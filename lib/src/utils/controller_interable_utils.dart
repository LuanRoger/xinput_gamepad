import 'package:xinput_gamepad/src/enums/controller_button.dart';

extension ControllerListUtils on List<ControllerButton> {
  List<ControllerButton> getContains(List<ControllerButton> left) {
    List<ControllerButton> contains = List.empty(growable: true);

    for (ControllerButton button in this) {
      if (left.contains(button)) {
        contains.add(button);
      }
    }

    return contains;
  }
}