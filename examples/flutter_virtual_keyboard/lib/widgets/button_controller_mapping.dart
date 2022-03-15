import 'package:flutter/material.dart';
import 'package:flutter_virtual_keyboard/controllers/home_page_controller.dart';
import 'package:provider/provider.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ButtonControllerMapping extends StatelessWidget {
  String text;
  final ControllerButton button;

  ButtonControllerMapping(this.text, {Key? key, required this.button})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Text(text),
      const SizedBox(
        width: 10,
      ),
      SizedBox(
        width: widthSize * 0.15,
        child: Consumer<HomePageController>(builder: (context, value, _) {
          return DropdownButton<KeyboardKey>(
            isExpanded: true,
              value: value.getButtonValue(button),
              items: KeyboardKey.values
                  .map((key) => DropdownMenuItem<KeyboardKey>(
                      value: key,
                      child: Text(
                        key.toString(),
                      )))
                  .toList(),
              onChanged: (key) {
                if (key == null) return;

                value.changeButtonMapping(button, key);
              });
        }),
      ),
    ]);
  }
}
