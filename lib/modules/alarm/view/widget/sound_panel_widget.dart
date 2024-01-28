import 'package:easy_alarm/common/asset_path.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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
  late final AudioPlayer _player;

  final TextStyle _labelTextStyle =
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: CustomColors.black);

  SoundAssetPath _selectedSound = SoundAssetPath.defaultSound;

  @override
  void initState() {
    _player = AudioPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("alarm.soundLabel".tr(), style: _labelTextStyle),
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
                    menuStyle: MenuStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        return CustomColors.white;
                      }),
                      elevation: MaterialStateProperty.resolveWith((states) => 5.0),
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      isDense: true,
                      isCollapsed: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: CustomColors.grey40, width: 2.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                        .map(
                          (e) => DropdownMenuEntry(
                            value: e,
                            label: e.name,
                            style: ButtonStyle(
                              textStyle: MaterialStateProperty.resolveWith(
                                (states) => const TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                        )
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
