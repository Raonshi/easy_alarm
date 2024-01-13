import 'package:easy_alarm/style/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SnoozePanelWidget extends StatefulWidget {
  const SnoozePanelWidget({super.key});

  @override
  State<SnoozePanelWidget> createState() => _SnoozePanelWidgetState();
}

class _SnoozePanelWidgetState extends State<SnoozePanelWidget> {
  TextStyle get _labelTextStyle =>
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: CustomColors.black);

  TextStyle get _timeTextStyle =>
      const TextStyle(fontSize: 57.0, height: 1.0, fontWeight: FontWeight.bold, color: CustomColors.black);

  TimeOfDay _time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text("alarm.snoozeLabel".tr(), style: _labelTextStyle),
        const SizedBox(height: 10.0),
        GestureDetector(
          onTap: () async {
            final TimeOfDay? time = await showTimePicker(
              context: context,
              initialTime: _time,
            );

            if (time != null) {
              setState(() {
                _time = time;
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: CustomColors.blue30,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(_time.hour.toString(), style: _timeTextStyle),
              ),
              SizedBox(width: 24.0, child: Text(":", style: _timeTextStyle, textAlign: TextAlign.center)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: CustomColors.blue30,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(_time.minute.toString(), style: _timeTextStyle),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
