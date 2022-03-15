import 'package:flutter/material.dart';
import 'package:flutter_virtual_keyboard/controllers/home_page_controller.dart';
import 'package:provider/provider.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

import 'pages/home_page.dart';

void main() {
  XInputManager.enableXInput();
  XInputManager.inputLag = 85;

  runApp(ChangeNotifierProvider(
      create: (context) => HomePageController(),
      child: MaterialApp(
        home: const HomePage(),
        theme: ThemeData(brightness: Brightness.dark),
      )));
}
