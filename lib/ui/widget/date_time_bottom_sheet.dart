import 'package:easy_alarm/common/tools.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimeBottomSheet extends StatelessWidget {
  const DateTimeBottomSheet({super.key, required this.initialTime});

  final TimeOfDay initialTime;

  TextStyle get _labelTextStyle =>
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: CustomColors.black);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text("common.cancel".tr(), style: _labelTextStyle),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text("common.complete".tr(), style: _labelTextStyle),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (dateTime) {
                final TimeOfDay time = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
                lgr.d("time: $time");
              },
            ),
          ),
        ],
      ),
    );
  }
}
