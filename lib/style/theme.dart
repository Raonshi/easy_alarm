import 'package:easy_alarm/style/text_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = FlexThemeData.light(
  useMaterial3: true,
  scheme: FlexScheme.brandBlue,
  appBarElevation: 0.0,
  applyElevationOverlayColor: false,
  appBarOpacity: 1.0,
  textTheme: textTheme
    ..apply(
      decorationColor: Colors.black,
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
);

ThemeData darkTheme = FlexThemeData.dark(
  useMaterial3: true,
  scheme: FlexScheme.brandBlue,
  appBarElevation: 0.0,
  applyElevationOverlayColor: false,
  appBarOpacity: 1.0,
  textTheme: textTheme
    ..apply(
      decorationColor: Colors.white,
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
);
