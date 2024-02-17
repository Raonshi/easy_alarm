import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EzCalendarEventDialog extends StatefulWidget {
  const EzCalendarEventDialog({super.key, required this.initialDate});

  final DateTime initialDate;

  @override
  State<EzCalendarEventDialog> createState() => _EzCalendarEventDialogState();
}

class _EzCalendarEventDialogState extends State<EzCalendarEventDialog> {
  bool _isAllDay = false;

  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    final DateTime now = DateTime.now();
    _startDate = DateTime(
      widget.initialDate.year,
      widget.initialDate.month,
      widget.initialDate.day,
      now.hour,
      now.minute,
    );
    _endDate = _startDate.add(const Duration(hours: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(disposition: UnfocusDisposition.previouslyFocusedChild),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 6.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                  Expanded(
                    child: Text(
                      "calendar.dialog.header".tr(),
                      style: textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 12.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Title
                  TextField(
                    decoration: InputDecoration(
                      labelStyle: textTheme.labelLarge,
                      labelText: "calendar.dialog.titleLabel".tr(),
                      contentPadding: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 12.0.w),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0.r),
                        borderSide: BorderSide(color: colors.primary, width: 1.0.w),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0.r),
                        borderSide: BorderSide(color: colors.primary, width: 1.0.w),
                      ),
                      suffix: Icon(Icons.close, color: colors.primary),
                    ),
                  ),
                  SizedBox(height: 24.0.h),

                  // Event Content
                  TextField(
                    decoration: InputDecoration(
                      labelStyle: textTheme.labelLarge,
                      labelText: "calendar.dialog.contentLabel".tr(),
                      contentPadding: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 12.0.w),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0.r),
                        borderSide: BorderSide(color: colors.primary, width: 1.0.w),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0.r),
                        borderSide: BorderSide(color: colors.primary, width: 1.0.w),
                      ),
                      suffix: Icon(Icons.close, color: colors.primary),
                    ),
                  ),
                  SizedBox(height: 24.0.h),

                  // Event Date
                  Text("calendar.dialog.dateLabel".tr(), style: textTheme.labelLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("calendar.dialog.allDayLabel".tr(), style: textTheme.labelLarge),
                      Switch(
                        value: _isAllDay,
                        onChanged: (value) => setState(() => _isAllDay = value),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("calendar.dialog.startDateLabel".tr(), style: textTheme.labelLarge),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: _startDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 365)),
                              ).then((value) {
                                if (value != null) {
                                  setState(() => _startDate = value);
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 6.0.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0.r),
                                border: Border.all(),
                                color: colors.primary.withOpacity(0.1),
                              ),
                              child: Text(
                                DateFormat("yyyy년 MM월 dd일").format(_startDate),
                                style: textTheme.bodyLarge,
                              ),
                            ),
                          ),
                          if (!_isAllDay) ...[
                            SizedBox(width: 8.0.w),
                            GestureDetector(
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(_startDate),
                                ).then((value) {
                                  if (value != null) {
                                    setState(
                                      () => _startDate = DateTime(
                                        _startDate.year,
                                        _startDate.month,
                                        _startDate.day,
                                        value.hour,
                                        value.minute,
                                      ),
                                    );
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 6.0.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0.r),
                                  border: Border.all(),
                                  color: colors.primary.withOpacity(0.1),
                                ),
                                child: Text(
                                  DateFormat("hh:mm").format(_startDate),
                                  style: textTheme.bodyLarge,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "calendar.dialog.endDateLabel".tr(),
                        style: textTheme.labelLarge,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: _endDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 365)),
                              ).then((value) {
                                if (value != null) {
                                  setState(() => _endDate = value);
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 6.0.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0.r),
                                border: Border.all(),
                                color: colors.primary.withOpacity(0.1),
                              ),
                              child: Text(
                                DateFormat("yyyy년 MM월 dd일").format(_endDate),
                                style: textTheme.bodyLarge,
                              ),
                            ),
                          ),
                          if (!_isAllDay) ...[
                            SizedBox(width: 8.0.w),
                            GestureDetector(
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(_endDate),
                                ).then((value) {
                                  if (value != null) {
                                    setState(
                                      () => _endDate = DateTime(
                                        _endDate.year,
                                        _endDate.month,
                                        _endDate.day,
                                        value.hour,
                                        value.minute,
                                      ),
                                    );
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 6.0.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0.r),
                                  border: Border.all(),
                                  color: colors.primary.withOpacity(0.1),
                                ),
                                child: Text(
                                  DateFormat("hh:mm").format(_endDate),
                                  style: textTheme.bodyLarge,
                                ),
                              ),
                            )
                          ],
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom.h),
          ],
        ),
      ),
    );
  }
}
