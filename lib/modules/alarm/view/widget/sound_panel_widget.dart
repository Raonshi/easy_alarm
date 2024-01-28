import 'package:easy_alarm/common/asset_path.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SoundPanelWidget extends StatefulWidget {
  const SoundPanelWidget({
    super.key,
    required this.onSelectSound,
  });

  final ValueChanged<SoundAssetPath> onSelectSound;

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
            // Expanded(
            //   flex: 4,
            //   child: DecoratedBox(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20.0),
            //       border: Border.all(color: CustomColors.grey40, width: 2.0),
            //     ),
            //     child: DropdownButton(
            //       value: _selectedSound,
            //       isExpanded: true,
            //       isDense: true,
            //       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            //       underline: const Offstage(),
            //       onChanged: (value) {
            //         setState(() => _selectedSound = value as SoundAssetPath);
            //         widget.onSelectSound(_selectedSound);
            //       },
            //       items: SoundAssetPath.values
            //           .map(
            //             (e) => DropdownMenuItem(
            //               value: e,
            //               child: Text(e.name),
            //             ),
            //           )
            //           .toList(),
            //     ),
            //   ),
            // ),
            Expanded(
              flex: 4,
              child: DropdownMenu(
                initialSelection: _selectedSound,
                requestFocusOnTap: false,
                enableSearch: false,
                enableFilter: false,
                inputDecorationTheme: InputDecorationTheme(
                  isDense: true,
                  isCollapsed: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: CustomColors.grey40, width: 2.0),
                  ),
                ),
                onSelected: (value) {
                  setState(() => _selectedSound = value as SoundAssetPath);
                  widget.onSelectSound(_selectedSound);
                },
                dropdownMenuEntries: SoundAssetPath.values
                    .map(
                      (e) => DropdownMenuEntry(
                        value: e,
                        label: e.name,
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
