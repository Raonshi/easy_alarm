import 'package:easy_alarm/style/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class VibratePanelWidget extends StatefulWidget {
  const VibratePanelWidget({
    super.key,
    required this.onTapSwitch,
  });

  final ValueChanged<bool> onTapSwitch;

  @override
  State<VibratePanelWidget> createState() => _VibratePanelWidgetState();
}

class _VibratePanelWidgetState extends State<VibratePanelWidget> {
  final TextStyle _labelTextStyle =
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: CustomColors.black);

  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("alarm.vibrateLabel".tr(), style: _labelTextStyle),
            Switch(
              value: _isEnabled,
              onChanged: (value) {
                setState(() => _isEnabled = value);
                widget.onTapSwitch(value);
              },
            ),
          ],
        ),
      ],
    );
  }
}
