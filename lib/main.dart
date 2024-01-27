import 'package:alarm/alarm.dart';
import 'package:easy_alarm/common/tools.dart';
import 'package:easy_alarm/core/notification_manager.dart';
import 'package:easy_alarm/core/route.dart';
import 'package:easy_alarm/ui/page/my_app.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // Receive background notification message
  // FirebaseMessaging.onBackgroundMessage(_onBackgroundNotification);
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Future.wait([
    EasyLocalization.ensureInitialized(),
    NotificationManager().init(),
    MobileAds.instance.initialize(),
    Alarm.init(showDebugLogs: true),
  ]);

  // Receive foreground notification message
  // FirebaseMessaging.onMessage.listen(_onForegroundNotification);

  Alarm.setNotificationOnAppKillContent("title", "body");

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      path: "assets/translations",
      fallbackLocale: const Locale("ko"),
      child: const MyApp(),
    ),
  );
}

// Future<void> _onForegroundNotification(RemoteMessage message) async {
//   final RemoteNotification? noti = message.notification;
//   lgr.d("_onForegroundNotification: ${noti?.title ?? ""} ${noti?.body ?? ""}");
//   if (noti != null) {
//     await NotificationManager().show(id: 0, title: noti.title ?? "", body: noti.body ?? "");
//   }
// }

// @pragma('vm:entry-point')
// Future<void> _onBackgroundNotification(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   final RemoteNotification? noti = message.notification;

//   lgr.d("_onBackgroundNotification: ${noti?.title ?? ""} ${noti?.body ?? ""}");

//   if (noti != null) {
//     await NotificationManager().initConfig();
//     await NotificationManager().show(id: 0, title: noti.title ?? "", body: noti.body ?? "");
//   }
// }

Future<void> onTapForegroundNotification(NotificationResponse details) async {
  lgr.d("onTapForegroundNotification: ${details.payload}");
  navKey.currentContext!.pushNamed(Path.alarm.path);
}

@pragma('vm:entry-point')
Future<void> onTapBackgroundNotification(NotificationResponse details) async {
  lgr.d("onTapBackgroundNotification: ${details.payload}");
  navKey.currentContext!.pushNamed(Path.alarm.path);
}
