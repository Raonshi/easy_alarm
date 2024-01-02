import 'package:easy_alarm/common/enums.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:flutter/material.dart';

class WeekdayPanelWidget extends StatefulWidget {
  const WeekdayPanelWidget(
      {super.key, required this.clickable, this.onSelectedDaysChanged, required this.selectedWeekdays});

  final bool clickable;
  final ValueChanged<List<Weekday>>? onSelectedDaysChanged;
  final List<Weekday> selectedWeekdays;

  @override
  State<WeekdayPanelWidget> createState() => _WeekdayPanelWidgetState();
}

class _WeekdayPanelWidgetState extends State<WeekdayPanelWidget> {
  final List<Weekday> _weekdays = [];
  final List<bool> _selectedDays = [];

  @override
  void initState() {
    _weekdays.addAll(widget.selectedWeekdays);
    _selectedDays.addAll(Weekday.values.map((weekday) => widget.selectedWeekdays.contains(weekday)).toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: Weekday.values.map((weekday) {
        final index = Weekday.values.indexOf(weekday);
        return _DayItem(
          dayText: weekday.text,
          isSelected: _selectedDays[index],
          activeBackgroundColor: getActiveBackgroundColor(weekday),
          activeForegroundColor: getActiveForegroundColor(weekday),
          inactiveBackgroundColor: CustomColors.grey30,
          inactiveForegroundColor: CustomColors.grey70,
          onTap: (isSelected) {
            setState(() {
              _selectedDays[index] = isSelected;
            });

            if (widget.onSelectedDaysChanged != null) {
              widget.onSelectedDaysChanged!(
                Weekday.values.where((element) => _selectedDays[Weekday.values.indexOf(element)]).toList(),
              );
            }
          },
          clickable: widget.clickable,
        );
      }).toList(),
    );
  }

  Color getActiveBackgroundColor(Weekday weekday) {
    if (weekday == Weekday.saturday) return CustomColors.blue30;
    if (weekday == Weekday.sunday) return CustomColors.red30;
    return CustomColors.green30;
  }

  Color getActiveForegroundColor(Weekday weekday) {
    if (weekday == Weekday.saturday) return CustomColors.blue70;
    if (weekday == Weekday.sunday) return CustomColors.red70;
    return CustomColors.green70;
  }
}

class _DayItem extends StatelessWidget {
  const _DayItem({
    required this.dayText,
    required this.activeBackgroundColor,
    required this.activeForegroundColor,
    required this.inactiveBackgroundColor,
    required this.inactiveForegroundColor,
    required this.isSelected,
    required this.onTap,
    required this.clickable,
  });
  final ValueChanged<bool> onTap;

  final String dayText;
  final bool isSelected;
  final bool clickable;
  final Color activeBackgroundColor;
  final Color activeForegroundColor;
  final Color inactiveBackgroundColor;
  final Color inactiveForegroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (clickable) onTap(!isSelected);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: ShapeDecoration(
          color: isSelected ? activeBackgroundColor : inactiveBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          dayText,
          style: TextStyle(
            fontSize: 22.0,
            height: 1.0,
            fontWeight: FontWeight.w700,
            color: isSelected ? activeForegroundColor : inactiveForegroundColor,
          ),
        ),
      ),
    );
  }
}
