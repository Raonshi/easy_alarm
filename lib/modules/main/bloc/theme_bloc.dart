import 'package:bloc/bloc.dart';
import 'package:easy_alarm/common/shared_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Cubit<ThemeMode> {
  ThemeBloc() : super(ThemeMode.system) {
    _init();
  }

  void _init() {
    SharedPreferences.getInstance().then((prefs) {
      final int storedThemeMode = prefs.getInt(LocalStorageKey.themeMode.text) ?? 0;
      emit(ThemeMode.values[storedThemeMode]);
    });
  }

  void changeTheme(ThemeMode themeMode) async {
    emit(themeMode);
    SharedPreferences.getInstance().then((prefs) async {
      await prefs.setInt(LocalStorageKey.themeMode.text, themeMode.index);
    });
  }
}
