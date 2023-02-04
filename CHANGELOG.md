## 1.3.0
- Add support to buttons combinations.
- [BREAKING CHANGE] Create assertations for ```Controller``` class.
- Update dependencies.
- Update examples.

## 1.2.3
- Fix crash from unknow state at initialization.
- ```_lastButtonsBitmask``` can't be null, it is 0 by default.
- onReleaseButton dont get not mapped buttons.
- [BREAKING CHANGE] onReleaseButton get more than one release per state.
- Fix boken changes and update examples pubspecs.

## 1.2.2
- Fix crash when press button that is not mapped.

## 1.2.1
- Migrate enums to enhanced enums.
- New SDK version required: '>=2.18.1 <3.0.0'.
- [BREAKING CHANGE] Remove UNKNOWN enum from ControllerFlag, ControllerType and BatteryLevel.

## 1.2.0
- Add ```Controller.onRawButtonEvent``` to use the raw controller bitmasks (Not documented).
- Support to multiple buttons press per state.
- [BREAKING CHANGE] Rename ```Controller.lister()``` to ```Controller.listen()```

## 1.1.0
- [BREAKING CHANGE] Remove virtual_keyboard
- [BREAKING CHANGE] Remove virtual_cursor

## 1.0.1
- Update dependencies version.
- Remove examples.

## 1.0.0
- Update README.
- Add ESCAPE keyboard's key.

## 0.0.8
- Documentation in-code updated.
- Rename files and some classes.

## 0.0.7
- Add mapping list to switch between them at runtime.
- ```getIndexConnectedControllers``` moved to ```ControllersManager```.

## 0.0.6
- Documentation in code created.
- Minor fixes.

## 0.0.5
- Created VirtualCursor.
- Some files and classes renamed.

## 0.0.4
- VirtualKeyboard complete.

## 0.0.3
- Created event to execute when some button is released.
- ButtonMode enum modified.
- Windows example added.

## 0.0.2
- Added VirtualKeyboard.

## 0.0.1
- Initial version.