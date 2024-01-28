import 'package:easy_alarm/modules/alarm/model/alarm_group/alarm_group.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:easy_alarm/ui/widget/week_day_panel_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AlarmItemWidget extends StatelessWidget {
  const AlarmItemWidget({
    super.key,
    required this.onTapDelete,
    required this.item,
    required this.onTapSwitch,
  });

  final AlarmGroup item;
  final ValueChanged<int> onTapDelete;
  final ValueChanged<int> onTapSwitch;

  TextStyle get _timeTextStyle => const TextStyle(fontSize: 32, fontWeight: FontWeight.w700);

  TextStyle get _snoozeTextStyle => const TextStyle(fontSize: 22, fontWeight: FontWeight.w700);

  String get dateTimeText {
    final DateTime dateTime = item.dateTime;
    final String hour = dateTime.hour.toString().padLeft(2, '0');
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute ${dateTime.hour > 12 ? "PM" : "AM"}';
  }

  String get snoozeText {
    final int? snoozeMinute = item.snoozeMinute;

    if (snoozeMinute == null) {
      return 'alarm.snoozeNone'.tr();
    } else {
      if (snoozeMinute == 0) {
        return 'alarm.snoozeNone'.tr();
      } else if (snoozeMinute < 60) {
        return 'alarm.snoozeMinute'.tr(args: [snoozeMinute.toString()]);
      } else {
        if (snoozeMinute % 60 == 0) {
          return 'alarm.snoozeHour'.tr(args: [(snoozeMinute ~/ 60).toString()]);
        } else {
          return 'alarm.snoozeHourAndMinute'.tr(args: [
            (snoozeMinute ~/ 60).toString(),
            (snoozeMinute % 60).toString(),
          ]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: item.isEnabled ? CustomColors.blue10 : CustomColors.grey10,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: CustomColors.grey30),
          borderRadius: BorderRadius.circular(16.0),
        ),
        shadows: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 4.0,
            spreadRadius: 0.0,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  dateTimeText,
                  style: _timeTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              InkWell(
                onTap: () => onTapDelete(item.id),
                child: const Icon(Icons.close),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  snoozeText,
                  style: _snoozeTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Switch(
                value: item.isEnabled,
                activeColor: CustomColors.grey10,
                inactiveThumbColor: CustomColors.grey40,
                trackOutlineColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return CustomColors.blue40;
                  }
                  return CustomColors.grey40;
                }),
                trackColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return CustomColors.blue40;
                  }
                  return CustomColors.grey10;
                }),
                onChanged: (_) {
                  onTapSwitch(item.id);
                },
              ),
            ],
          ),
          WeekdayPanelWidget(
            clickable: false,
            selectedWeekdays: item.weekdays,
          ),
        ],
      ),
    );
  }
}
