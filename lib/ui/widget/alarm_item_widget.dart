import 'package:easy_alarm/common/enums.dart';
import 'package:easy_alarm/model/alarm_model/alarm_model.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:easy_alarm/ui/widget/week_day_panel_widget.dart';
import 'package:flutter/material.dart';

class AlarmItemWidget extends StatefulWidget {
  const AlarmItemWidget({super.key, required this.onTapDelete, required this.item});

  final AlarmModel item;
  final ValueChanged<String> onTapDelete;

  @override
  State<AlarmItemWidget> createState() => _AlarmItemWidgetState();
}

class _AlarmItemWidgetState extends State<AlarmItemWidget> {
  late bool _isEnabled;

  @override
  void initState() {
    _isEnabled = widget.item.weekdays.isNotEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: _isEnabled ? CustomColors.blue10 : CustomColors.grey10,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: CustomColors.grey30),
          borderRadius: BorderRadius.circular(16.0),
        ),
        shadows: [
          BoxShadow(
              offset: const Offset(0, 4), blurRadius: 4.0, spreadRadius: 0.0, color: Colors.black.withOpacity(0.25)),
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("6:00am", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
              InkWell(
                onTap: () => widget.onTapDelete(widget.item.id),
                child: const Icon(Icons.close),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.item.snoozeTimeText, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              Switch(
                value: _isEnabled,
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
                onChanged: (value) => setState(() {
                  _isEnabled = value;
                }),
              ),
            ],
          ),
          WeekdayPanelWidget(
            clickable: false,
            selectedWeekdays: widget.item.weekdays,
            onSelectedDaysChanged: (List<Weekday> value) {},
          )
        ],
      ),
    );
  }
}
