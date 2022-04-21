import 'package:flutter/material.dart';
import 'package:flutter_virtual_keyboard/controllers/home_page_controller.dart';
import 'package:flutter_virtual_keyboard/widgets/button_controller_mapping.dart';
import 'package:provider/provider.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                const Text("Controller index:"),
                const SizedBox(
                  width: 10,
                ),
                Consumer<HomePageController>(builder: (context, value, _) {
                  return DropdownButton<int>(
                      value: value.controller.index,
                      items: ControllersManager.getIndexConnectedControllers()
                          .map((index) => DropdownMenuItem(
                                value: index,
                                child: Text(index.toString()),
                              ))
                          .toList(),
                      onChanged: (index) {
                        if (index == null) return;
                        value.changeControllerIndex(index);
                      });
                }),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: GridView.count(
              physics: const ScrollPhysics(),
              childAspectRatio: 3,
              crossAxisCount: 3,
              shrinkWrap: true,
              children: [
                ButtonControllerMapping("A Button",
                    button: ControllerButton.A_BUTTON),
                ButtonControllerMapping("B Button",
                    button: ControllerButton.B_BUTTON),
                ButtonControllerMapping("X Button",
                    button: ControllerButton.X_BUTTON),
                ButtonControllerMapping("Y Button",
                    button: ControllerButton.Y_BUTTON),
                ButtonControllerMapping("DPAD UP",
                    button: ControllerButton.DPAD_UP),
                ButtonControllerMapping("DPAD DOWN",
                    button: ControllerButton.DPAD_DOWN),
                ButtonControllerMapping("DPAD LEFT",
                    button: ControllerButton.DPAD_LEFT),
                ButtonControllerMapping("DPAD RIGHT",
                    button: ControllerButton.DPAD_RIGHT),
                ButtonControllerMapping("START",
                    button: ControllerButton.START),
                ButtonControllerMapping("BACK",
                    button: ControllerButton.BACK),
                ButtonControllerMapping("LEFT THUMB",
                    button: ControllerButton.LEFT_THUMB),
                ButtonControllerMapping("RIGHT THUMB",
                    button: ControllerButton.RIGHT_THUMB),
                ButtonControllerMapping("LEFT SHOULDER",
                    button: ControllerButton.LEFT_SHOULDER),
                ButtonControllerMapping("RIGH SHOULDER",
                    button: ControllerButton.RIGHT_SHOULDER)
              ],
            ),
          )
        ],
      ),
    ));
  }
}
