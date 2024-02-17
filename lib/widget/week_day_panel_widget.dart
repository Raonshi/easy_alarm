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
          inactiveBackgroundColor: Theme.of(context).disabledColor.withOpacity(0.1),
          inactiveForegroundColor: Theme.of(context).disabledColor,
          onTap: (isSelected) {
            final int currentWeekday = DateTime.now().weekday;
            if (currentWeekday == weekday) {
              final List<bool> tmp = _selectedDays.toList();
              tmp.removeAt(weekday - 1);
              if (tmp.every((element) => element == false)) return;
            }

            setState(() {
              _selectedDays[weekday - 1] = isSelected;
              if (_selectedDays.every((element) => element == false)) {
                _selectedDays[currentWeekday - 1] = true;
              }
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
    if (weekday == 6) return Colors.blue.shade300;
    if (weekday == 7) return Colors.red.shade300;
    return Colors.green.shade300;
  }

  Color getActiveForegroundColor(int weekday) {
    if (weekday == 6) return Colors.blue.shade700;
    if (weekday == 7) return Colors.red.shade700;
    return Colors.green.shade700;
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
