# xinput_gamepad
### Add support to XInput controllers with Win32 API.

## Dependencies
- [win32](https://pub.dev/packages/win32)

## Features
- Handle controller inputs easily;
- Get controllers information (Battery type, battery level, controller type and more);
- Get connected controllers;
- Set input lag and controller's deadzone;
- Set and use controller's vibration motor;
- Simulate keyboard and mouse inputs with controller;

## Instalation
*Not available*

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
XInputManager.getIndexConnectedControllers();
```

See all the examples:
| Name | Description |
|------|-------------|
| [console](https://github.com/LuanRoger/xinput_gamepad/tree/main/examples/console) | Get controller inputs and show what button is pressed. |
| [flutter_windwos](https://github.com/LuanRoger/xinput_gamepad/tree/main/examples/flutter_windows) | Shows what button is pressed in each connected controller and the thumbs and triggers variation. |
| [flutter_virutal_keyboard](https://github.com/LuanRoger/xinput_gamepad/tree/main/examples/flutter_virtual_keyboard) | Map each keyboard key to controller handler. |
> See examples ready-to-run [here](https://github.com/LuanRoger/xinput_gamepad/tree/main/examples/pre_builded_examples)

## Documentation
*Soon*
