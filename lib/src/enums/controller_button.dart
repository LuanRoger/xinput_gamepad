// ignore_for_file: constant_identifier_names

//DPAD UP - 1 - 0x0001
//DPAD DOWN - 2 - 0x0002
//DPAD LEFT - 4 - 0X0004
//DPAD RIGHT - 8 - 0X0008
//START - 16 - 0X0010
//BACK - 32 - 0X0032
//LEFT THUMB - 64 - 0X0064
//RIGHT THUMB - 128 - 0X0080
//LEFT SHOULDER - 256 - 0X0100
//RIGHT SHOULDER - 512 - 0X0200
//A - 4096 - 0x1000
//B - 8192 - 0x2000
//X - 16384 - 0x8000
//Y - 32768 - 0x4000

//See more: https://docs.microsoft.com/pt-br/windows/win32/api/XInput/ns-xinput-xinput_gamepad
enum ControllerButton {
  DPAD_UP,
  DPAD_DOWN,
  DPAD_LEFT,
  DPAD_RIGHT,
  START,
  BACK,
  LEFT_THUMB,
  RIGHT_THUMB,
  LEFT_SHOULDER,
  RIGHT_SHOULDER,
  A_BUTTON,
  B_BUTTON,
  X_BUTTON,
  Y_BUTTON
}
