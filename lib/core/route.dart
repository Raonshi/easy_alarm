import 'package:easy_alarm/modules/alarm/view/page/add_page.dart';
import 'package:easy_alarm/modules/alarm/view/page/alarm_page.dart';
import 'package:easy_alarm/modules/home/view/page/home_page.dart';
import 'package:easy_alarm/modules/main/view/page/shell_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum Path {
  home("/home"),
  add("/add"),
  alarm("/alarm");

  final String path;

  const Path(this.path);
}

final GlobalKey<NavigatorState> mainNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: mainNavKey,
  initialLocation: Path.home.path,
  routes: [
    ShellRoute(
      navigatorKey: shellNavKey,
      routes: [
        GoRoute(
          path: Path.home.path,
          name: Path.home.path,
          pageBuilder: (context, state) => NoTransitionPage(child: HomePage(state: state)),
        ),
        GoRoute(
          path: Path.add.path,
          name: Path.add.path,
          builder: (context, state) => const AddPage(),
        ),
        GoRoute(
          path: Path.alarm.path,
          name: Path.alarm.path,
          builder: (context, state) => AlarmPage(state: state),
        ),
      ],
      pageBuilder: (context, state, child) => NoTransitionPage(
        child: ShellPage(state: state, child: child),
      ),
    ),
  ],
);
