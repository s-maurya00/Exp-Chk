import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController {
  final _box = GetStorage();
  final _keyName = "isDarkMode";

  _saveThemeToBox(bool isDarkMode) => _box.write(_keyName, isDarkMode);

  bool _loadThemeFromBox() => _box.read(_keyName) ?? false;

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);

    _saveThemeToBox(!_loadThemeFromBox());
  }
}
