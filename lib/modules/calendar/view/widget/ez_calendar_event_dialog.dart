import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EzCalendarEventDialog extends StatefulWidget {
  const EzCalendarEventDialog({super.key});

  @override
  State<EzCalendarEventDialog> createState() => _EzCalendarEventDialogState();
}

class _EzCalendarEventDialogState extends State<EzCalendarEventDialog> {
  bool _isAllDay = false;
  bool _isRange = false;
  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: colors.background,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
                Text("calendar.dialog.header".tr()),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.check),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("calendar.dialog.titleLabel".tr()),
                  TextField(),
                  Text("calendar.dialog.contentLabel".tr()),
                  TextField(),
                  Text("calendar.dialog.dateLabel".tr()),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("calendar.dialog.rangeLabel".tr()),
                      Switch(
                        value: _isRange,
                        onChanged: (value) {
                          setState(() => _isRange = value);
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("calendar.dialog.allDayLabel".tr()),
                      Switch(
                        value: _isAllDay,
                        onChanged: (value) {
                          setState(() => _isAllDay = value);
                        },
                      ),
                    ],
                  ),
                  if (_isRange) ...[
                    Text("calendar.dialog.startDateLabel".tr()),
                    Text("calendar.dialog.endDateLabel".tr()),
                  ] else
                    Text("calendar.dialog.dateLabel".tr()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
