import 'package:easy_alarm/style/colors.dart';
import 'package:easy_alarm/widget/week_day_panel_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RoutinePanelWidget extends StatefulWidget {
  const RoutinePanelWidget({
    super.key,
    required this.selectedWeekdays,
    required this.onTapSwitch,
    required this.onSelectedDaysChanged,
  });

  final List<int> selectedWeekdays;
  final ValueChanged<bool> onTapSwitch;
  final ValueChanged<List<int>> onSelectedDaysChanged;

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
              inactiveTrackColor: CustomColors.grey10,
              activeColor: CustomColors.blue40,
              thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) return CustomColors.white;
                return CustomColors.grey40;
              }),
              trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) return Colors.transparent;
                return CustomColors.grey40;
              }),
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
