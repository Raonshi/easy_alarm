import 'package:alarm/alarm.dart';
import 'package:easy_alarm/common/tools.dart';
import 'package:easy_alarm/core/route.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_entity/alarm_entity.dart';
import 'package:go_router/go_router.dart';

class NotificationManager {
  final String _tag = "[NotificationManager]";
  static final NotificationManager _instance = NotificationManager._internal();
  factory NotificationManager() => _instance;
  NotificationManager._internal();

  Future<void> init() async {
    await initConfig();
    lgr.d("[Notification Manager] initialized");
  }

  Future<void> initConfig() async {
    await initAlarm();
  }

  Future<void> initAlarm() async {
    await Alarm.init(showDebugLogs: true);
    await Alarm.setNotificationOnAppKillContent("title", "body");

    Alarm.ringStream.stream.listen(_handleAlarmRinging);
  }

  Future<void> _handleAlarmRinging(AlarmSettings settings) async {
    navKey.currentContext!.pushNamed(Path.alarm.path, extra: settings);
  }

  Future<void> addAlarm(AlarmEntity alarm) async {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(alarm.timestamp);
    late final DateTime alarmDateTime;

    if (alarm.weekdays.isEmpty) {
      final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
      alarmDateTime = currentTimestamp > alarm.timestamp ? dateTime.add(const Duration(days: 7)) : dateTime;

      final AlarmSettings setting = AlarmSettings(
        id: alarm.id,
        dateTime: alarmDateTime,
        assetAudioPath: "assets/sound/0.mp3",
        notificationTitle: alarm.title,
        notificationBody: alarm.content,
      );
      await Alarm.set(alarmSettings: setting);
    } else {
      List<AlarmSettings> settings = alarm.weekdays.map((weekday) {
        if (weekday > dateTime.weekday) {
          alarmDateTime = dateTime.add(Duration(days: weekday - dateTime.weekday));
        } else if (weekday < dateTime.weekday) {
          alarmDateTime = dateTime.add(Duration(days: 7 - dateTime.weekday + weekday));
        } else {
          final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
          alarmDateTime = currentTimestamp > alarm.timestamp ? dateTime.add(const Duration(days: 7)) : dateTime;
        }

        return AlarmSettings(
          id: alarm.id,
          dateTime: alarmDateTime,
          assetAudioPath: "assets/sound/0.mp3",
          notificationTitle: alarm.title,
          notificationBody: alarm.content,
        );
      }).toList();

      await Future.wait(settings.map((e) => Alarm.set(alarmSettings: e)));
    }

    List<AlarmSettings> alarms = Alarm.getAlarms();
    lgr.d(alarms);
  }
}
