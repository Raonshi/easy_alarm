import 'package:easy_alarm/style/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SnoozePanelWidget extends StatefulWidget {
  const SnoozePanelWidget({
    super.key,
    required this.onTapSwitch,
    required this.snoozeTime,
    required this.onTimeChanged,
  });

  final TimeOfDay snoozeTime;
  final ValueChanged<bool> onTapSwitch;
  final ValueChanged<TimeOfDay?> onTimeChanged;

  @override
  State<SnoozePanelWidget> createState() => _SnoozePanelWidgetState();
}

class _SnoozePanelWidgetState extends State<SnoozePanelWidget> {
  bool _isEnabled = false;

  TextStyle get _labelTextStyle => const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: CustomColors.black,
      );

  TextStyle get _timeTextStyle => TextStyle(
        fontSize: 57.0,
        height: 1.0,
        fontWeight: FontWeight.bold,
        color: _isEnabled ? CustomColors.black : CustomColors.grey30,
      );

  String get _hourText => (_isEnabled ? widget.snoozeTime.hour.toString() : "0").padLeft(2, "0");
  String get _minuteText => (_isEnabled ? widget.snoozeTime.minute.toString() : "0").padLeft(2, "0");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("alarm.snoozeLabel".tr(), style: _labelTextStyle),
            Switch(
              value: _isEnabled,
              onChanged: (value) {
                setState(() => _isEnabled = value);
                widget.onTapSwitch(value);
              },
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        GestureDetector(
          onTap: () async {
            if (!_isEnabled) return;
            final TimeOfDay? time = await showTimePicker(
              context: context,
              initialTime: widget.snoozeTime,
            );
            widget.onTimeChanged(time);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: _isEnabled ? CustomColors.blue30 : CustomColors.grey10,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(_hourText, style: _timeTextStyle),
              ),
              SizedBox(width: 24.0, child: Text(":", style: _timeTextStyle, textAlign: TextAlign.center)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: _isEnabled ? CustomColors.blue30 : CustomColors.grey10,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(_minuteText, style: _timeTextStyle),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
