import 'package:easy_alarm/modules/alarm/view/page/add_page.dart';
import 'package:easy_alarm/modules/alarm/view/page/alarm_page.dart';
import 'package:easy_alarm/modules/home/view/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum Path {
  home("/"),
  add("add"),
  alarm("alarm");

  final String path;

  const Path(this.path);
}

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
String initialRoute = Path.home.path;

final GoRouter router = GoRouter(
  navigatorKey: navKey,
  initialLocation: initialRoute,
  routes: [
    GoRoute(
      path: Path.home.path,
      name: Path.home.path,
      parentNavigatorKey: navKey,
      pageBuilder: (context, state) => const NoTransitionPage(child: HomePage()),
      routes: [
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
    ),
  ],
);
