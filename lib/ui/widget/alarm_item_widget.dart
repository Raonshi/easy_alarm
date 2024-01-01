import 'package:easy_alarm/ui/widget/week_day_panel_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AlarmItemWidget extends StatelessWidget {
  const AlarmItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(12.0),
        ),
        shadows: [
          BoxShadow(offset: Offset(0, 4), blurRadius: 4.0, spreadRadius: 0.0, color: Colors.black.withOpacity(0.25)),
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
              Text("6:00am", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
              Icon(Icons.close),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("alarm.snooze".tr(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              Switch(value: false, onChanged: (value) {}),
            ],
          ),
          WeekdayPanelWidget()
        ],
      ),
    );
  }
}
