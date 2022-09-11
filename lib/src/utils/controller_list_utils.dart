import 'package:xinput_gamepad/src/enums/controller_button.dart';

extension ControllerListUtils on List<ControllerButton> {
  List<ControllerButton> operator -(List<ControllerButton> left) {
    List<ControllerButton> complement = List.empty(growable: true);

    for (var button in left) {
      if (!contains(button)) {
        complement.add(button);
      }
    }

    return complement;
  }
}
