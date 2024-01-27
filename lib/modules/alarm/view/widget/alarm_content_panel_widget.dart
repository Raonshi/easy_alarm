import 'package:easy_alarm/style/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AlarmContentPanelWidget extends StatelessWidget {
  const AlarmContentPanelWidget({super.key, required this.onChangedTitle, required this.onChangedContent});

  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedContent;

  TextStyle get _labelTextStyle =>
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: CustomColors.black);

  TextStyle get _inputStyle =>
      const TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: CustomColors.black);

  InputDecoration get _inputDecoration => InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: CustomColors.blue50),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: CustomColors.grey50),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text("alarm.contentLabel".tr(), style: _labelTextStyle),
        const SizedBox(height: 10.0),
        TextField(
          style: _inputStyle,
          maxLines: 1,
          textInputAction: TextInputAction.next,
          decoration: _inputDecoration.copyWith(
            labelText: "alarm.title".tr(),
          ),
          onChanged: onChangedTitle,
        ),
        const SizedBox(height: 20.0),
        const Divider(height: 2.0, thickness: 2.0, color: CustomColors.grey10),
        const SizedBox(height: 10.0),
        TextField(
          style: _inputStyle,
          maxLines: null,
          minLines: 1,
          textInputAction: TextInputAction.newline,
          decoration: _inputDecoration.copyWith(
            labelText: "alarm.content".tr(),
          ),
          onChanged: onChangedContent,
        ),
      ],
    );
  }
}
