import 'package:easy_alarm/style/colors.dart';
import 'package:flutter/material.dart';

class WeekdayPanelWidget extends StatefulWidget {
  const WeekdayPanelWidget(
      {super.key, required this.clickable, this.onSelectedDaysChanged, required this.selectedWeekdays});

  final bool clickable;
  final ValueChanged<List<int>>? onSelectedDaysChanged;
  final List<int> selectedWeekdays;

  @override
  State<WeekdayPanelWidget> createState() => _WeekdayPanelWidgetState();
}

class _WeekdayPanelWidgetState extends State<WeekdayPanelWidget> {
  final List<bool> _selectedDays = [];
  final List<int> _weekdaysInKorean = [1, 2, 3, 4, 5, 6, 7];

  @override
  void initState() {
    _selectedDays.addAll(_weekdaysInKorean.map((weekday) => widget.selectedWeekdays.contains(weekday)).toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _weekdaysInKorean.map((weekday) {
        return _DayItem(
          weekday: weekday,
          isSelected: _selectedDays[weekday - 1],
          activeBackgroundColor: getActiveBackgroundColor(weekday),
          activeForegroundColor: getActiveForegroundColor(weekday),
          inactiveBackgroundColor: CustomColors.grey30,
          inactiveForegroundColor: CustomColors.grey70,
          onTap: (isSelected) {
            if (weekday == DateTime.now().weekday) return;
            setState(() {
              _selectedDays[weekday - 1] = isSelected;
            });

            if (widget.onSelectedDaysChanged != null) {
              final List<int> selectedWeekDays =
                  _weekdaysInKorean.where((element) => _selectedDays[_weekdaysInKorean.indexOf(element)]).toList();

              widget.onSelectedDaysChanged!(selectedWeekDays);
            }
          },
          clickable: widget.clickable,
        );
      }).toList(),
    );
  }

  Color getActiveBackgroundColor(int weekday) {
    if (weekday == 6) return CustomColors.blue30;
    if (weekday == 7) return CustomColors.red30;
    return CustomColors.green30;
  }

  Color getActiveForegroundColor(int weekday) {
    if (weekday == 6) return CustomColors.blue70;
    if (weekday == 7) return CustomColors.red70;
    return CustomColors.green70;
  }
}

class _DayItem extends StatelessWidget {
  const _DayItem({
    required this.weekday,
    required this.activeBackgroundColor,
    required this.activeForegroundColor,
    required this.inactiveBackgroundColor,
    required this.inactiveForegroundColor,
    required this.isSelected,
    required this.onTap,
    required this.clickable,
  });
  final ValueChanged<bool> onTap;

  final int weekday;
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

  String get dayText {
    switch (weekday) {
      case 1:
        return "월";
      case 2:
        return "화";
      case 3:
        return "수";
      case 4:
        return "목";
      case 5:
        return "금";
      case 6:
        return "토";
      case 7:
        return "일";
      default:
        return "";
    }
  }
}
