import 'package:easy_alarm/common/asset_path.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:easy_alarm/ui/widget/week_day_panel_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SoundPanelWidget extends StatefulWidget {
  const SoundPanelWidget({
    super.key,
    required this.onTapSwitch,
  });

  final ValueChanged<bool> onTapSwitch;

  @override
  State<SoundPanelWidget> createState() => _SoundPanelWidgetState();
}

class _SoundPanelWidgetState extends State<SoundPanelWidget> {
  final TextStyle _labelTextStyle =
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: CustomColors.black);

  SoundAssetPath _selectedSound = SoundAssetPath.defaultSound;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 7,
              child: Text("alarm.soundLabel".tr(), style: _labelTextStyle),
            ),
            Expanded(
              flex: 4,
              child: DropdownButton(
                value: _selectedSound,
                isExpanded: true,
                onChanged: (value) {
                  setState(() => _selectedSound = value as SoundAssetPath);
                  widget.onTapSwitch(true);
                },
                items: SoundAssetPath.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
