# xinput_gamepad
### Add support to XInput controllers with Win32 API.
![badge_version](https://img.shields.io/pub/v/xinput_gamepad)
![badge_license](https://img.shields.io/github/license/LuanRoger/xinput_gamepad)
![badge_sdk](https://img.shields.io/badge/sdk-dart%20%7C%20flutter-blue)
![badge_platform](https://img.shields.io/badge/platform-windows-blue)

## Dependencies
- [win32](https://pub.dev/packages/win32)
- [ffi](https://pub.dev/packages/ffi)

## Features
- Handle controller inputs easily;
- Get controllers information (Battery type, battery level, controller type and more);
- Get connected controllers;
- Set more than one button mapping per controller;
- Set input lag and controller's deadzone;
- Set and use controller's vibration motor;
- Simulate keyboard and mouse inputs with controller;

## Instalation
With Dart
```powershell
dart pub add xinput_gamepad
```
With Flutter
```powershell
flutter pub add xinput_gamepad
```
See more in [install section](https://pub.dev/packages/xinput_gamepad/install)

## Simple example
Enable XInput:
```dart
XInputManager.enableXInput();
```
Init and map the controller:
```dart
final Controller controller = Controller(index: 0);
controller.buttonsMapping = {
  ControllerButton.A_BUTTON: () =>
      print("Controller $controllerIndex - Button A"),
  ControllerButton.B_BUTTON: () =>
      print("Controller $controllerIndex - Button B"),
  ControllerButton.X_BUTTON: () =>
      print("Controller $controllerIndex - Button X"),
  ControllerButton.Y_BUTTON: () =>
      print("Controller $controllerIndex - Button Y"),
};

//Start to listen inputs
controller.lister();
```
You can get the indexes of the available/connected controllers with:
```dart
ControllersManager.getIndexConnectedControllers();
```
See all practical examples [here](https://github.com/LuanRoger/xinput_gamepad/tree/main/examples)

## Documentation
Access the documentation [here](https://github.com/LuanRoger/xinput_gamepad/wiki)
