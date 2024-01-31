import 'package:bloc/bloc.dart';
import 'package:easy_alarm/common/asset_path.dart';
import 'package:easy_alarm/common/tools.dart';
import 'package:easy_alarm/core/alarm_manager.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_entity/alarm_entity.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_group/alarm_group.dart';
import 'package:easy_localization/easy_localization.dart';

import 'add_state.dart';

class AddBloc extends Cubit<AddState> {
  final AlarmManager _alarmManager = AlarmManager();

  AddBloc() : super(const AddState.initial()) {
    _init();
  }

  void _init() async {
    state.mapOrNull(initial: (state) {
      final int id = _alarmManager.firstEmptyId;
      final DateTime now = DateTime.now();
      final int timestamp = DateTime(now.year, now.month, now.day, now.hour, now.minute, 0).millisecondsSinceEpoch;

      final AlarmEntity newAlarmEntity = AlarmEntity(
        id: timestamp,
        timestamp: timestamp,
        sound: SoundAssetPath.defaultSound,
      );

      emit(AddState.loaded(alarmGroup: AlarmGroup(id: id, alarms: [newAlarmEntity])));
    });
  }

  void updateTime(DateTime inputDate) {
    state.mapOrNull(loaded: (state) {
      final List<AlarmEntity> newAlarms = state.alarmGroup.alarms.map((alarm) {
        final DateTime newAlarmTime = DateTime(
          alarm.dateTime.year,
          alarm.dateTime.month,
          alarm.dateTime.day,
          inputDate.hour,
          inputDate.minute,
        );

        return alarm.copyWith(
          id: newAlarmTime.millisecondsSinceEpoch,
          timestamp: newAlarmTime.millisecondsSinceEpoch,
        );
      }).toList();
      lgr.d("INPUT:$inputDate\nOUTPUT:${newAlarms.map((e) => e.dateTime)}");
      emit(state.copyWith(alarmGroup: state.alarmGroup.copyWith(alarms: newAlarms)));
    });
  }

  void updateWeekdays(bool isRoutine, List<int> newWeekdays) {
    state.mapOrNull(loaded: (state) {
      final int timestamp = state.alarmGroup.alarms.first.timestamp;
      final SoundAssetPath sound = state.alarmGroup.alarms.first.sound;

      final List<AlarmEntity> newAlarms = newWeekdays
          .map((e) => AlarmEntity(
                id: timestamp,
                timestamp: timestamp,
                sound: sound,
              ))
          .toList();

      emit(state.copyWith(
        selectedWeekdays: newWeekdays,
        alarmGroup: state.alarmGroup.copyWith(alarms: newAlarms, routine: isRoutine),
      ));
    });
  }

  void updateSnoozeTime([Duration? duration]) {
    state.mapOrNull(loaded: (state) {
      final List<AlarmEntity> newAlarms = state.alarmGroup.alarms.toList().map((e) {
        return e.copyWith(
          snoozeDuration: duration?.inMinutes,
          nextTimstamp: duration == null ? null : e.timestamp + duration.inMilliseconds,
        );
      }).toList();

      final AlarmGroup newAlarmGroup = state.alarmGroup.copyWith(alarms: newAlarms);
      emit(state.copyWith(alarmGroup: newAlarmGroup));
    });
  }

  void updateSound(SoundAssetPath newSound) {
    state.mapOrNull(loaded: (state) {
      final List<AlarmEntity> newAlarms = state.alarmGroup.alarms.toList().map((e) {
        return e.copyWith(sound: newSound);
      }).toList();

      final AlarmGroup newAlarmGroup = state.alarmGroup.copyWith(alarms: newAlarms);
      emit(state.copyWith(alarmGroup: newAlarmGroup));
    });
  }

  void updateVibration(bool newVibration) {
    state.mapOrNull(loaded: (state) {
      final List<AlarmEntity> newAlarms = state.alarmGroup.alarms.toList().map((e) {
        return e.copyWith(vibration: newVibration);
      }).toList();

      final AlarmGroup newAlarmGroup = state.alarmGroup.copyWith(alarms: newAlarms);
      emit(state.copyWith(alarmGroup: newAlarmGroup));
    });
  }

  Future<void> save() async {
    await state.mapOrNull(loaded: (state) async {
      final DateTime now = DateTime.now();
      final List<AlarmEntity> currentAlarms = state.alarmGroup.alarms.toList();
      final List<int> selectedWeekdays = state.selectedWeekdays.toList();

      if (selectedWeekdays.isEmpty) selectedWeekdays.add(now.weekday);

      currentAlarms.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      final List<AlarmEntity> finalAlarms = [];

      for (int i = 0; i < selectedWeekdays.length; i++) {
        final int weekday = selectedWeekdays[i];
        final int timestamp = currentAlarms[i].timestamp;
        final DateTime alarmDate = DateTime.fromMillisecondsSinceEpoch(timestamp);

        DateTime finalizedDate;
        if (weekday < now.weekday) {
          finalizedDate = alarmDate.add(Duration(days: 7 - now.weekday + weekday));
        } else if (weekday > now.weekday) {
          finalizedDate = alarmDate.add(Duration(days: weekday - now.weekday));
        } else {
          finalizedDate = DateTime(now.year, now.month, now.day, alarmDate.hour, alarmDate.minute, 0);
          if (finalizedDate.isBefore(now)) finalizedDate = finalizedDate.add(const Duration(days: 7));
        }

        final int? nextTimestamp = currentAlarms[i].snoozeDuration == null
            ? null
            : finalizedDate.add(Duration(minutes: currentAlarms[i].snoozeDuration!)).millisecondsSinceEpoch;

        finalAlarms.add(currentAlarms[i].copyWith(
          id: finalizedDate.millisecondsSinceEpoch,
          timestamp: finalizedDate.millisecondsSinceEpoch,
          nextTimstamp: nextTimestamp,
        ));
      }

      final AlarmGroup finalizedAlarmGroup = state.alarmGroup.copyWith(alarms: finalAlarms);
      // log("==================== ALARMS ====================");
      // log("ROUTINE : ${finalizedAlarmGroup.routine}");
      // for (AlarmEntity alarm in finalizedAlarmGroup.alarms) {
      //   log("ID               : ${alarm.id}");
      //   log("ALARM DATE       : ${alarm.dateTime}");
      //   log("NEXT ALARM TIME  : ${alarm.nextDateTime}");
      //   log("SOUND            : ${alarm.sound}");
      //   log("VIBRATION        : ${alarm.vibration}");
      //   log("SNOOZE DURATION  : ${alarm.snoozeDuration}");
      //   log("-----------------------------------------------");
      // }
      // log("================================================");
      await _alarmManager.saveAlarm(finalizedAlarmGroup);
    });
  }

  Future<String?> validate() async {
    return state.maybeMap(
      loaded: (state) {
        if (state.alarmGroup.alarms.isEmpty) return "exception.emptyAlarm".tr();
        if (state.alarmGroup.routine && (state.selectedWeekdays.length != state.alarmGroup.alarms.length)) {
          return "exception.notSyncWeekday".tr();
        }

        for (AlarmEntity alarm in state.alarmGroup.alarms) {
          if (alarm.snoozeDuration != null && alarm.snoozeDuration! < 1) return "exception.invalidSnoozeDuration".tr();
        }

        return null;
      },
      orElse: () => "exception.unknown".tr(),
    );
  }
}
