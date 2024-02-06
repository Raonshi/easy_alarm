import 'package:easy_alarm/common/asset_path.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SoundPanelWidget extends StatefulWidget {
  const SoundPanelWidget({
    super.key,
    required this.player,
    required this.onSelectSound,
  });
  final AudioPlayer player;
  final ValueChanged<SoundAssetPath> onSelectSound;

  @override
  State<SoundPanelWidget> createState() => _SoundPanelWidgetState();
}

class _SoundPanelWidgetState extends State<SoundPanelWidget> {
  late final AudioPlayer _player;

  final TextStyle _labelTextStyle = const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

  SoundAssetPath _selectedSound = SoundAssetPath.defaultSound;

  @override
  void initState() {
    _player = widget.player;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "alarm.soundLabel".tr(),
              style: _labelTextStyle.copyWith(color: colors.onBackground),
            ),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility.maintain(
                    visible: _player.playing,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _player.stop();
                        });
                      },
                      icon: const Icon(Icons.stop),
                    ),
                  ),
                  DropdownMenu(
                    initialSelection: _selectedSound,
                    requestFocusOnTap: false,
                    enableSearch: false,
                    enableFilter: false,
                    onSelected: (value) async {
                      if (value == null) return;
                      if (_player.playing) await _player.stop();

                      await _player.setAsset(value.path);

                      setState(() {
                        _selectedSound = value;
                        _player.play();
                      });
                      widget.onSelectSound(_selectedSound);
                    },
                    dropdownMenuEntries: SoundAssetPath.values
                        .map((e) => DropdownMenuEntry(
                              value: e,
                              label: e.name,
                              style: MenuItemButton.styleFrom(
                                foregroundColor: colors.onBackground,
                                textStyle: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  height: 1.0,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
