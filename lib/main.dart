import 'dart:developer';

import 'package:easy_alarm/core/notification_manager.dart';
import 'package:easy_alarm/core/route.dart';
import 'package:easy_alarm/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // Receive background notification message
  FirebaseMessaging.onBackgroundMessage(_onBackgroundNotification);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Future.wait([
    EasyLocalization.ensureInitialized(),
    NotificationManager().init(),
    MobileAds.instance.initialize(),
  ]);

  // await EasyLocalization.ensureInitialized();
  // await NotificationManager().init();
  // await MobileAds.instance.initialize();

  // Receive foreground notification message
  FirebaseMessaging.onMessage.listen(_onForegroundNotification);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      path: "assets/translations",
      fallbackLocale: const Locale("ko"),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Receive foreground notification message
    FirebaseMessaging.onMessage.listen((event) async {
      final RemoteNotification? noti = event.notification;
      if (noti != null) {
        await NotificationManager().show(id: 0, title: noti.title ?? "", body: noti.body ?? "");
      }
    });

    return MaterialApp.router(
      title: 'Easy Alarm',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}

Future<void> _onForegroundNotification(RemoteMessage message) async {
  final RemoteNotification? noti = message.notification;
  log("Foreground Notification: ${noti?.title ?? ""} ${noti?.body ?? ""}");
  
  if (noti != null) {
    await NotificationManager().show(id: 0, title: noti.title ?? "", body: noti.body ?? "");
  }
}

@pragma('vm:entry-point')
Future<void> _onBackgroundNotification(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final RemoteNotification? noti = message.notification;

  log("Background Notification: ${noti?.title ?? ""} ${noti?.body ?? ""}");

  if (noti != null) {
    await NotificationManager().initConfig();
    await NotificationManager().show(id: 0, title: noti.title ?? "", body: noti.body ?? "");
  }
}
