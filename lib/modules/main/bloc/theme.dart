import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeBloc extends Cubit<ThemeMode> {
  ThemeBloc() : super(ThemeMode.system);

  void changeTheme(ThemeMode themeMode) {
    emit(themeMode);
  }
}
