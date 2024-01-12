import 'package:easy_alarm/style/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TimerPanelWidget extends StatelessWidget {
  const TimerPanelWidget({super.key});

  TextStyle get _labelTextStyle =>
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: CustomColors.black);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("alarm.setTimeLabel".tr(), style: _labelTextStyle),
      ],
    );
  }
}
