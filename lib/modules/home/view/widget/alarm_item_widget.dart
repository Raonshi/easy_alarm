import 'package:easy_alarm/modules/alarm/model/alarm_group/alarm_group.dart';
import 'package:easy_alarm/style/icons.dart';
import 'package:easy_alarm/widget/week_day_panel_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: ShapeDecoration(
        color: item.isEnabled ? theme.colorScheme.surfaceVariant : theme.colorScheme.outlineVariant,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: theme.colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(16.0.r),
        ),
        shadows: [
          BoxShadow(
            offset: Offset(0.w, 4.h),
            blurRadius: 4.0.r,
            spreadRadius: 0.0.r,
            color: theme.shadowColor.withOpacity(0.26),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.0.h),
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
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: item.isEnabled ? theme.colorScheme.onSurfaceVariant : theme.disabledColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              InkWell(
                onTap: () => onTapDelete(item.id),
                child: SvgPicture.asset(
                  CustomIcons.close,
                  width: 24.0,
                  height: 24.0,
                  colorFilter: ColorFilter.mode(
                    item.isEnabled ? theme.colorScheme.onSurfaceVariant : theme.disabledColor,
                    BlendMode.srcIn,
                  ),
                ),
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
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: item.isEnabled ? theme.colorScheme.onSurfaceVariant : theme.disabledColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Switch(
                value: item.isEnabled,
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
