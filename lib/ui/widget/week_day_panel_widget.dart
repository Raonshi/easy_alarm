import 'package:flutter/material.dart';

class WeekdayPanelWidget extends StatelessWidget {
  const WeekdayPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: ["월", "화", "수", "목", "금", "토", "일"]
          .map(
            (dayText) => _DayItem(
              dayText: dayText,
              activeBackgroundColor: Colors.green.shade300,
              activeForegroundColor: Colors.green.shade500,
              inactiveBackgroundColor: Colors.white,
              inactiveForegroundColor: Colors.black,
            ),
          )
          .toList(),
    );
  }
}

class _DayItem extends StatelessWidget {
  const _DayItem({
    required this.dayText,
    required this.activeBackgroundColor,
    required this.activeForegroundColor,
    required this.inactiveBackgroundColor,
    required this.inactiveForegroundColor,
  });

  final String dayText;
  final Color activeBackgroundColor;
  final Color activeForegroundColor;
  final Color inactiveBackgroundColor;
  final Color inactiveForegroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        dayText,
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
