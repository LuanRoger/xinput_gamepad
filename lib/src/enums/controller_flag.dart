///Flags that indicate the features which are supported.
///
///UNKNOWN - Is unknown.
///
///VOICE_SUPPORTED - Device has an integrated voice device.
///
///FORCE_FEEDBACK_SUPPORTED - Device supports force feedback functionality. Note that these force-feedback features beyond rumble are not currently supported through XINPUT on Windows.
///
///WIRELESS - Device is wireless.
///
///PLUGIN_MODULES_SUPPORTED -	Device supports plug-in modules. Note that plug-in modules like the text input device (TID) are not supported currently through XINPUT on Windows.
///
///NO_NAVIGATION - Device lacks menu navigation buttons (START, BACK, DPAD).
enum ControllerFlag {
  UNKNOWN,
  VOICE_SUPPORTED,
  FORCE_FEEDBACK_SUPPORTED,
  WIRELESS,
  PLUGIN_MODULES_SUPPORTED,
  NO_NAVIGATION
}
