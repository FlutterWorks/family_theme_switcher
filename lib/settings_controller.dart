// ignore_for_file: use_setters_to_change_properties, document_ignores

import 'package:flutter/material.dart';

class SettingsController {
  SettingsController();

  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.system);

  ValueNotifier<ThemeMode> get themeMode => _themeMode;

  void setThemeMode({required ThemeMode themeMode}) {
    _themeMode.value = themeMode;
  }

  void dispose() {
    _themeMode.dispose();
  }
}
