import 'package:easy_alarm/common/enums.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:easy_alarm/ui/widget/week_day_panel_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RoutinePanelWidget extends StatefulWidget {
  const RoutinePanelWidget({
    super.key,
    required this.selectedWeekdays,
    required this.onTapSwitch,
    required this.onSelectedDaysChanged,
  });

  final List<Weekday> selectedWeekdays;
  final ValueChanged<bool> onTapSwitch;
  final ValueChanged<List<Weekday>> onSelectedDaysChanged;

  @override
  State<RoutinePanelWidget> createState() => _RoutinePanelWidgetState();
}

class _RoutinePanelWidgetState extends State<RoutinePanelWidget> {
  final TextStyle _labelTextStyle =
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: CustomColors.black);

  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("alarm.routineLabel".tr(), style: _labelTextStyle),
            Switch(
              value: _isEnabled,
              onChanged: (value) {
                setState(() => _isEnabled = value);
                widget.onTapSwitch(value);
              },
            ),
          ],
        ),
        Visibility(
          visible: _isEnabled,
          child: WeekdayPanelWidget(
            clickable: true,
            selectedWeekdays: widget.selectedWeekdays,
            onSelectedDaysChanged: widget.onSelectedDaysChanged,
          ),
        ),
      ],
    );
  }
}
