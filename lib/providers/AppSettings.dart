import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  static Color themeDark = Color(0xff021f2d);
  static Color themeDarker = Color(0xff000d14);
  static Color themeLight = Color(0xffffd8d1);

  Color _mainColor = themeDark;
  Color _secondaryColor = themeLight;
  Color _textColor = themeLight;

  Color get mainColor => _mainColor;

  Color get secondaryColor => _secondaryColor;

  bool _isLightThemeActive = true;

  bool get isLightThemeActive => _isLightThemeActive;

  Color get textColor => _textColor;

  setLightTheme() {
    _isLightThemeActive = true;
    _mainColor = themeDark;
    _secondaryColor = themeLight;
    notifyListeners();
  }

  setDarkTheme() {
    //Todo: Make it look awesome!
    _isLightThemeActive = false;
    _mainColor = themeDark;
    _secondaryColor = themeDarker;
    notifyListeners();
  }

  toggleTheme() {
    if (_isLightThemeActive) {
      setDarkTheme();
    } else {
      setLightTheme();
    }
  }
}
