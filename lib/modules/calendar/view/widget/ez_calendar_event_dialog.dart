import 'package:flutter/material.dart';

class EzCalendarEventDialog extends StatelessWidget {
  const EzCalendarEventDialog({super.key});

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
                const Text("Event add widget"),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.check),
                ),
              ],
            ),
            const Text("Event add widget"),
            const Text("Event add widget"),
            const Text("Event add widget"),
            const Text("Event add widget"),
            const Text("Event add widget"),
            const Text("Event add widget"),
          ],
        ),
      ),
    );
  }
}
