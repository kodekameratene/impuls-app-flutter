import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorProvider extends ChangeNotifier {
  static Color themeDark = Color(0xff021f2d);
  static Color themeDarker = Color(0xff000d14);
  static Color themeLight = Color(0xffffd8d1);

  static Color _foreGroundColor = Color(0xff000d14);
  static Color _backGroundColor = Color(0xffffd8d1);

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

class AppSettings extends ChangeNotifier {
  bool _showSecrets = false;
  String _appName = '';
  String _packageName = '';
  String _version = '';
  String _buildNumber = '';

  AppSettings() {
    syncStorage();
    getAppInfo();
  }

  bool get shouldShowSecrets => _showSecrets;

  String get appName => _appName;

  String get packageName => _packageName;

  String get version => _version;

  String get buildNumber => _buildNumber;

  Future<void> syncStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var showSecrets = prefs.getBool('show_secrets');
    if (showSecrets != null) {
      _showSecrets = showSecrets;
    }
    notifyListeners();
  }

  showSecrets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('show_secrets', true);
    _showSecrets = true;
    notifyListeners();
  }

  hideSecrets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('show_secrets', false);
    _showSecrets = false;
    notifyListeners();
  }

  getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _appName = packageInfo.appName;
    _packageName = packageInfo.packageName;
    _version = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;
    notifyListeners();
  }
}
