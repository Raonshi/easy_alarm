import 'package:easy_alarm/style/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerPanelWidget extends StatelessWidget {
  const TimerPanelWidget({super.key, required this.time, required this.onTimeChanged});

  final DateTime time;
  final ValueChanged<DateTime> onTimeChanged;

  TextStyle get _labelTextStyle =>
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: CustomColors.black);

  TextStyle get _timeTextStyle =>
      const TextStyle(fontSize: 57.0, height: 1.0, fontWeight: FontWeight.bold, color: CustomColors.black);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text("alarm.setTimeLabel".tr(), style: _labelTextStyle),
        const SizedBox(height: 10.0),
        GestureDetector(
          onTap: () async {
            await showModalBottomSheet(
              context: context,
              showDragHandle: true,
              isScrollControlled: true,
              builder: (subContext) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: true,
                        onDateTimeChanged: (dateTime) {
                          onTimeChanged(dateTime);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
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
                child: Text(time.hour.toString().padLeft(2, "0"), style: _timeTextStyle),
              ),
              SizedBox(width: 24.0, child: Text(":", style: _timeTextStyle, textAlign: TextAlign.center)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: CustomColors.blue30,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(time.minute.toString().padLeft(2, "0"), style: _timeTextStyle),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
