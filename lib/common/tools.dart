import 'package:easy_alarm/core/route.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

Logger get lgr => Logger();

void showSnackBar(String message) {
  ScaffoldMessenger.of(navKey.currentContext!).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
