import 'package:easy_alarm/core/route.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

Logger get lgr => Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
  filter: DevelopmentFilter(),
  output: ConsoleOutput(),
);

void showSnackBar(String message) {
  ScaffoldMessenger.of(mainNavKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(message),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      elevation: 0.0,
    ),
  );
}
