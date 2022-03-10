# xinput_gamepad
### Add support to XInput controllers with Win32 API.

## Dependencies
- [win32](https://pub.dev/packages/win32)

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
| [console](https://github.com/LuanRoger/xinput_gamepad/tree/main/examples) | Get controller inputs and show what button is pressed. |

## Documentation
*Soon*
