import 'dart:developer';
import 'dart:io';
import 'package:easy_alarm/model/alarm_model/alarm_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();
  factory NotificationManager() => _instance;
  NotificationManager._internal();

  final FlutterLocalNotificationsPlugin notiPlugin = FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  String? fcmToken;

  void initConfig() async {
    await _isAndroidPermissionGranted();
    await _requestPermissions();

    const AndroidInitializationSettings androidSetting = AndroidInitializationSettings(
      'mipmap/ic_launcher',
    );

    const DarwinInitializationSettings iosSetting = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      requestProvisionalPermission: false,
      requestCriticalPermission: false,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
      defaultPresentBanner: true,
      defaultPresentList: true,
      notificationCategories: [],
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSetting,
      iOS: iosSetting,
    );

    await notiPlugin.initialize(initSettings);
    await _initFcmToken();
    await _configureLocalTimeZone();
    log("[Notification Manager] initialized");
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await notiPlugin
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await notiPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await notiPlugin
          .resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          notiPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission = await androidImplementation?.requestNotificationsPermission();
    }
  }

  Future<void> _initFcmToken() async {
    fcmToken = await _fcm.getToken();
    log("FCM TOKEN : $fcmToken");

    // Receive foreground notification message
    FirebaseMessaging.onMessage.listen((event) async {
      final RemoteNotification? noti = event.notification;
      if (noti != null) {
        await show(id: 0, title: noti.title ?? "", body: noti.body ?? "");
      }
    });
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> show({required int id, required String title, required String body}) async {
    await notiPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('assets/sounds/0.mp3'),
          playSound: true,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> schedule({required AlarmModel alarm}) async {
    final DateTime now = DateTime.now();

    final DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      alarm.time.hour,
      alarm.time.minute,
    );

    final tz.TZDateTime nextSchedule = tz.TZDateTime.from(
      dateTime,
      tz.local,
    );

    await notiPlugin.zonedSchedule(
      alarm.id,
      alarm.title,
      alarm.content,
      nextSchedule,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  Future<void> cancelAlarmNotification(int id) async {
    await notiPlugin.cancel(id);
  }
}
