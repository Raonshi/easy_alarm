import 'package:easy_alarm/style/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: CustomColors.blue10,
    onPrimary: CustomColors.grey100,
    secondary: CustomColors.blue30,
    onSecondary: CustomColors.grey100,
    error: CustomColors.red70,
    onError: CustomColors.white,
    background: CustomColors.grey10,
    onBackground: CustomColors.grey100,
    surface: CustomColors.white,
    onSurface: CustomColors.black,
  ),
);
