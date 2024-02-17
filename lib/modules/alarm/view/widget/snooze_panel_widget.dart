import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnoozePanelWidget extends StatefulWidget {
  const SnoozePanelWidget({
    super.key,
    required this.onTapSwitch,
    required this.snoozeTime,
    required this.onDurationChanged,
  });

  final TimeOfDay snoozeTime;
  final ValueChanged<bool> onTapSwitch;
  final ValueChanged<Duration?> onDurationChanged;

  @override
  State<SnoozePanelWidget> createState() => _SnoozePanelWidgetState();
}

class _SnoozePanelWidgetState extends State<SnoozePanelWidget> {
  bool _isEnabled = false;

  TextStyle get _labelTextStyle => const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

  TextStyle get _timeTextStyle => const TextStyle(fontSize: 57.0, height: 1.0, fontWeight: FontWeight.bold);

  String get _hourText => (_isEnabled ? widget.snoozeTime.hour.toString() : "0").padLeft(2, "0");
  String get _minuteText => (_isEnabled ? widget.snoozeTime.minute.toString() : "0").padLeft(2, "0");

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "alarm.snoozeLabel".tr(),
              style: _labelTextStyle.copyWith(color: theme.colorScheme.onBackground),
            ),
            Switch(
              value: _isEnabled,
              onChanged: (value) {
                setState(() => _isEnabled = value);
                widget.onTapSwitch(value);
              },
            ),
          ],
        ),
        SizedBox(height: 10.0.h),
        GestureDetector(
          onTap: () async {
            if (!_isEnabled) return;
            await showModalBottomSheet(
              context: context,
              showDragHandle: true,
              isScrollControlled: true,
              builder: (subContext) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: (MediaQuery.of(context).size.height * 0.2).h,
                      child: CupertinoTimerPicker(
                        mode: CupertinoTimerPickerMode.hm,
                        onTimerDurationChanged: (duration) {
                          widget.onDurationChanged(duration);
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
                padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
                decoration: BoxDecoration(
                  color: _isEnabled ? theme.colorScheme.primary : theme.disabledColor,
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
                child: Text(
                  _hourText,
                  style: _timeTextStyle.copyWith(
                    color: _isEnabled ? theme.colorScheme.onPrimary : theme.disabledColor,
                  ),
                ),
              ),
              SizedBox(
                width: 24.0.w,
                child: Text(
                  ":",
                  style: _timeTextStyle.copyWith(
                    color: _isEnabled ? theme.colorScheme.primary : theme.disabledColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
                decoration: BoxDecoration(
                  color: _isEnabled ? theme.colorScheme.primary : theme.disabledColor,
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
                child: Text(
                  _minuteText,
                  style: _timeTextStyle.copyWith(
                    color: _isEnabled ? theme.colorScheme.onPrimary : theme.disabledColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
