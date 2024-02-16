import 'package:easy_alarm/style/colors.dart';
import 'package:easy_alarm/style/text_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// Light Theme
// ThemeData lightTheme = ThemeData(
//   brightness: Brightness.light,
//   colorScheme: const ColorScheme.light(
//     brightness: Brightness.light,
//     primary: CustomColors.blue10,
//     onPrimary: CustomColors.grey100,
//     secondary: CustomColors.blue40,
//     onSecondary: CustomColors.grey100,
//     error: CustomColors.red70,
//     onError: CustomColors.white,
//     background: CustomColors.grey10,
//     onBackground: CustomColors.grey100,
//     surface: CustomColors.white,
//     onSurface: CustomColors.black,
//     outline: CustomColors.grey30,
//   ),
//   disabledColor: CustomColors.grey40,
//   appBarTheme: const AppBarTheme(
//     backgroundColor: CustomColors.grey10,
//     elevation: 0.0,
//     centerTitle: false,
//     titleTextStyle: TextStyle(
//       fontSize: 32.0,
//       fontWeight: FontWeight.bold,
//       color: CustomColors.black,
//     ),
//   ),
//   switchTheme: SwitchThemeData(
//     thumbColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         return CustomColors.grey10;
//       }
//       return CustomColors.grey40;
//     }),
//     trackOutlineColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         return CustomColors.blue40;
//       }
//       return CustomColors.grey40;
//     }),
//     trackColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         return CustomColors.blue40;
//       }
//       return CustomColors.grey10;
//     }),
//   ),
//   dropdownMenuTheme: DropdownMenuThemeData(
//     textStyle: const TextStyle(
//       fontSize: 14.0,
//       fontWeight: FontWeight.w500,
//       height: 1.0,
//       letterSpacing: -0.5,
//       color: CustomColors.grey90,
//     ),
//     menuStyle: MenuStyle(
//       backgroundColor: MaterialStateColor.resolveWith((states) {
//         return CustomColors.white;
//       }),
//       elevation: MaterialStateProperty.resolveWith((states) => 5.0),
//       shape: MaterialStateProperty.resolveWith(
//         (states) => RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       isDense: true,
//       isCollapsed: true,
//       contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(20.0),
//         borderSide: const BorderSide(color: CustomColors.grey40, width: 2.0),
//       ),
//       suffixIconColor: CustomColors.grey90,
//     ),
//   ),
//   textTheme: textTheme
//     ..apply(
//       decorationColor: CustomColors.grey90,
//       bodyColor: CustomColors.grey90,
//       displayColor: CustomColors.grey90,
//     ),
//   extensions: [
//     TimePanelThemeData.light(),
//   ],
// );
//
/// Dark Theme
// ThemeData darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   colorScheme: const ColorScheme.dark(
//     brightness: Brightness.dark,
//     primary: CustomColors.blueGrey90,
//     onPrimary: CustomColors.grey10,
//     secondary: CustomColors.blue80,
//     onSecondary: CustomColors.grey100,
//     error: CustomColors.red70,
//     onError: CustomColors.white,
//     background: CustomColors.blueGrey80,
//     onBackground: CustomColors.blueGrey10,
//     surface: CustomColors.blueGrey60,
//     onSurface: CustomColors.black,
//     outline: CustomColors.blueGrey70,
//   ),
//   disabledColor: CustomColors.grey40,
//   appBarTheme: const AppBarTheme(
//     backgroundColor: CustomColors.blueGrey80,
//     elevation: 0.0,
//     centerTitle: false,
//     foregroundColor: CustomColors.blueGrey10,
//     titleTextStyle: TextStyle(
//       fontSize: 32.0,
//       fontWeight: FontWeight.bold,
//       color: CustomColors.blueGrey10,
//     ),
//   ),
//   switchTheme: SwitchThemeData(
//     thumbColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         return CustomColors.grey10;
//       }
//       return CustomColors.grey40;
//     }),
//     trackOutlineColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         return CustomColors.blue80;
//       }
//       return CustomColors.grey40;
//     }),
//     trackColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         return CustomColors.blue80;
//       }
//       return CustomColors.grey10;
//     }),
//   ),
//   dropdownMenuTheme: DropdownMenuThemeData(
//     textStyle: const TextStyle(
//       fontSize: 14.0,
//       fontWeight: FontWeight.w500,
//       height: 1.0,
//       letterSpacing: -0.5,
//       color: CustomColors.blueGrey10,
//     ),
//     menuStyle: MenuStyle(
//       backgroundColor: MaterialStateColor.resolveWith((states) {
//         return CustomColors.blueGrey90;
//       }),
//       surfaceTintColor: MaterialStateColor.resolveWith((states) {
//         return CustomColors.blueGrey10;
//       }),
//       elevation: MaterialStateProperty.resolveWith((states) => 5.0),
//       shape: MaterialStateProperty.resolveWith(
//         (states) => RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       isDense: true,
//       isCollapsed: true,
//       contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(20.0),
//         borderSide: const BorderSide(color: CustomColors.blueGrey70, width: 2.0),
//       ),
//       suffixIconColor: CustomColors.blueGrey10,
//     ),
//   ),
//   textTheme: textTheme
//     ..apply(
//       decorationColor: CustomColors.blueGrey10,
//       bodyColor: CustomColors.blueGrey10,
//       displayColor: CustomColors.blueGrey10,
//     ),
//   extensions: [
//     TimePanelThemeData.dark(),
//   ],
// );

ThemeData lightTheme = FlexThemeData.light(
  scheme: FlexScheme.flutterDash,
  textTheme: textTheme
    ..apply(
      decorationColor: Colors.black,
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
);

ThemeData darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.flutterDash,
  textTheme: textTheme
    ..apply(
      decorationColor: Colors.white,
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
);

// class TimePanelThemeData extends ThemeExtension<TimePanelThemeData> {
//   final Color enabledBackgroundColor;
//   final Color disabledBackgroundColor;
//   final Color enabledForegroundColor;
//   final Color disabledForegroundColor;

//   TimePanelThemeData({
//     required this.enabledBackgroundColor,
//     required this.disabledBackgroundColor,
//     required this.enabledForegroundColor,
//     required this.disabledForegroundColor,
//   });

//   factory TimePanelThemeData.light() {
//     return TimePanelThemeData(
//       enabledBackgroundColor: Colors.blue30,
//       disabledBackgroundColor: Colors.grey30,
//       enabledForegroundColor: Colors.grey90,
//       disabledForegroundColor: Colors.grey50,
//     );
//   }

//   factory TimePanelThemeData.dark() {
//     return TimePanelThemeData(
//       enabledBackgroundColor: CustomColors.blueGrey90,
//       disabledBackgroundColor: CustomColors.blueGrey70,
//       enabledForegroundColor: CustomColors.grey10,
//       disabledForegroundColor: CustomColors.grey50,
//     );
//   }

//   @override
//   ThemeExtension<TimePanelThemeData> copyWith({
//     Color? enabledBackgroundColor,
//     Color? disabledBackgroundColor,
//     Color? enabledForegroundColor,
//     Color? disabledForegroundColor,
//   }) {
//     return TimePanelThemeData(
//       enabledBackgroundColor: enabledBackgroundColor ?? this.enabledBackgroundColor,
//       disabledBackgroundColor: disabledBackgroundColor ?? this.disabledBackgroundColor,
//       enabledForegroundColor: enabledForegroundColor ?? this.enabledForegroundColor,
//       disabledForegroundColor: disabledForegroundColor ?? this.disabledForegroundColor,
//     );
//   }

//   @override
//   ThemeExtension<TimePanelThemeData> lerp(covariant TimePanelThemeData other, double t) {
//     return TimePanelThemeData(
//       enabledBackgroundColor: Color.lerp(enabledBackgroundColor, other.enabledBackgroundColor, t)!,
//       disabledBackgroundColor: Color.lerp(disabledBackgroundColor, other.disabledBackgroundColor, t)!,
//       enabledForegroundColor: Color.lerp(enabledForegroundColor, other.enabledForegroundColor, t)!,
//       disabledForegroundColor: Color.lerp(disabledForegroundColor, other.disabledForegroundColor, t)!,
//     );
//   }
// }
