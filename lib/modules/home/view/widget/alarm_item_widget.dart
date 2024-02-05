import 'package:easy_alarm/modules/alarm/model/alarm_group/alarm_group.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:easy_alarm/style/icons.dart';
import 'package:easy_alarm/widget/week_day_panel_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
    final ColorScheme colors = Theme.of(context).colorScheme;
    final Color disabledColor = Theme.of(context).disabledColor;

    return Container(
      decoration: ShapeDecoration(
        color: item.isEnabled ? colors.primary : colors.background,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colors.outline),
          borderRadius: BorderRadius.circular(16.0),
        ),
        shadows: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 4.0,
            spreadRadius: 0.0,
            color: CustomColors.black.withOpacity(0.25),
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
                  style: _timeTextStyle.copyWith(
                    color: item.isEnabled ? colors.onPrimary : disabledColor,
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
                    item.isEnabled ? colors.onPrimary : disabledColor,
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
                  style: _snoozeTextStyle.copyWith(
                    color: item.isEnabled ? colors.onPrimary : disabledColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Switch(
                value: item.isEnabled,
                activeColor: CustomColors.grey10,
                inactiveThumbColor: colors.outline,
                trackOutlineColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return colors.secondary;
                  }
                  return disabledColor;
                }),
                trackColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return colors.secondary;
                  }
                  return colors.background;
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
