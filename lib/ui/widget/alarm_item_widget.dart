import 'package:easy_alarm/modules/alarm/model/alarm_entity/alarm_entity.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:easy_alarm/ui/widget/week_day_panel_widget.dart';
import 'package:flutter/material.dart';

class AlarmItemWidget extends StatelessWidget {
  const AlarmItemWidget({
    super.key,
    required this.onTapDelete,
    required this.item,
    required this.onTapSwitch,
  });

  final AlarmEntity item;
  final ValueChanged<int> onTapDelete;
  final ValueChanged<int> onTapSwitch;

  TextStyle get _timeTextStyle => const TextStyle(fontSize: 32, fontWeight: FontWeight.w700);

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
              Text(item.timeString, style: _timeTextStyle),
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
              Text(item.snoozeString, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
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
