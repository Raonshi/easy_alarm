import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimerPanelWidget extends StatelessWidget {
  const TimerPanelWidget({super.key, required this.time, required this.onTimeChanged});

  final DateTime time;
  final ValueChanged<DateTime> onTimeChanged;

  TextStyle get _timeTextStyle => const TextStyle(fontSize: 57.0, height: 1.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "alarm.setTimeLabel".tr(),
          style: textTheme.labelLarge?.copyWith(color: theme.colorScheme.onBackground),
        ),
        SizedBox(height: 10.0.h),
        GestureDetector(
          onTap: () async {
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
                padding:  EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
                child: Text(
                  time.hour.toString().padLeft(2, "0"),
                  style: _timeTextStyle.copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
              SizedBox(
                width: 24.0.w,
                child: Text(
                  ":",
                  style: _timeTextStyle.copyWith(color: theme.colorScheme.primary),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding:  EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
                child: Text(
                  time.minute.toString().padLeft(2, "0"),
                  style: _timeTextStyle.copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
