import 'package:flutter/material.dart';
import 'package:flutter_windows/pages/home_page.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

void main() {
  XInputManager.enableXInput();
  XInputManager.inputLag = 0;

  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(
      brightness: Brightness.dark,
      textTheme: const TextTheme(
          bodyText2: TextStyle(color: Color.fromRGBO(26, 28, 25, 1))),
      backgroundColor: const Color.fromRGBO(28, 27, 30, 1),
    ),
  ));
}
