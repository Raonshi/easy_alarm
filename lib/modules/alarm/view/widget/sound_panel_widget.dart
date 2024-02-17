import 'package:easy_alarm/common/asset_path.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("alarm.soundLabel".tr(), style: theme.textTheme.labelLarge),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility.maintain(
                    visible: _player.playing,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                      onPressed: () {
                        setState(() {
                          _player.stop();
                        });
                      },
                      icon: const Icon(Icons.stop),
                    ),
                  ),
                  SizedBox(width: 8.0.w),
                  DropdownMenu(
                    initialSelection: _selectedSound,
                    requestFocusOnTap: false,
                    enableSearch: false,
                    enableFilter: false,
                    textStyle: theme.textTheme.bodyMedium,
                    inputDecorationTheme: InputDecorationTheme(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
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
                                foregroundColor: theme.colorScheme.onBackground,
                                textStyle: theme.textTheme.bodyMedium,
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
