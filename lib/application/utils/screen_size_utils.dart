class ScreenSizeUtils {
  static const _screenHeightThreshHold = 800;
  static bool isShortScreen(double height) {
    return height < _screenHeightThreshHold;
  }
}
