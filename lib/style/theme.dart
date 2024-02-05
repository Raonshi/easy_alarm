import 'package:easy_alarm/style/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    brightness: Brightness.light,
    primary: CustomColors.blue10,
    onPrimary: CustomColors.grey100,
    secondary: CustomColors.blue40,
    onSecondary: CustomColors.grey100,
    error: CustomColors.red70,
    onError: CustomColors.white,
    background: CustomColors.grey10,
    onBackground: CustomColors.grey100,
    surface: CustomColors.white,
    onSurface: CustomColors.black,
    outline: CustomColors.grey30,
  ),
  disabledColor: CustomColors.grey40,
  appBarTheme: const AppBarTheme(
    backgroundColor: CustomColors.grey10,
    elevation: 0.0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: CustomColors.black,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.light(
    brightness: Brightness.dark,
    primary: CustomColors.blueGrey90,
    onPrimary: CustomColors.grey10,
    secondary: CustomColors.blue80,
    onSecondary: CustomColors.grey100,
    error: CustomColors.red70,
    onError: CustomColors.white,
    background: CustomColors.blueGrey80,
    onBackground: CustomColors.blueGrey10,
    surface: CustomColors.blueGrey60,
    onSurface: CustomColors.black,
    outline: CustomColors.blueGrey70,
  ),
  disabledColor: CustomColors.grey40,
  appBarTheme: const AppBarTheme(
    backgroundColor: CustomColors.blueGrey80,
    elevation: 0.0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: CustomColors.blueGrey10,
    ),
  ),
);
