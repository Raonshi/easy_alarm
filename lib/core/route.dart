import 'package:easy_alarm/core/ez_path.dart';
import 'package:easy_alarm/modules/alarm/view/page/ez_add_page.dart';
import 'package:easy_alarm/modules/alarm/view/page/ez_alarm_page.dart';
import 'package:easy_alarm/modules/alarm/view/page/ez_ring_page.dart';
import 'package:easy_alarm/modules/calendar/view/page/ez_calendar_page.dart';
import 'package:easy_alarm/modules/main/view/page/shell_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> mainNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: mainNavKey,
  initialLocation: EzPath.alarm,
  routes: [
    ShellRoute(
      navigatorKey: shellNavKey,
      routes: [
        GoRoute(
          path: EzPath.alarm,
          name: EzPath.alarm,
          pageBuilder: (context, state) => NoTransitionPage(child: EzAlarmPage(state: state)),
          routes: [
            GoRoute(
              path: EzPath.add,
              name: EzPath.add,
              builder: (context, state) => const EzAddPage(),
            ),
          ],
        ),
        GoRoute(
          path: EzPath.calendar,
          name: EzPath.calendar,
          pageBuilder: (context, state) => NoTransitionPage(child: EzCalendarPage(state: state)),
        )
      ],
      pageBuilder: (context, state, child) => NoTransitionPage(
        child: ShellPage(state: state, child: child),
      ),
    ),
    GoRoute(
      path: EzPath.ring,
      name: EzPath.ring,
      builder: (context, state) => EzRingPage(state: state),
    ),
  ],
);
