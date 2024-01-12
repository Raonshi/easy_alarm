import 'package:easy_alarm/style/colors.dart';
import 'package:easy_alarm/ui/widget/routine_panel_widget.dart';
import 'package:easy_alarm/ui/widget/timer_panel_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AddAlarmBottomSheet extends StatelessWidget {
  const AddAlarmBottomSheet({super.key});

  TextStyle get _topButtonTextStyle =>
      const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: CustomColors.black);

  TextStyle get _labelTextStyle =>
      const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: CustomColors.black);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text("common.close".tr(), style: _topButtonTextStyle),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text("common.complete".tr(), style: _topButtonTextStyle),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30.0),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: TimerPanelWidget(),
          ),
          const Divider(height: 2.0, thickness: 2.0, color: CustomColors.grey10),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: RoutinePanelWidget(),
          ),
          const Divider(height: 2.0, thickness: 2.0, color: CustomColors.grey10),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("alarm.snoozeLabel".tr(), style: _labelTextStyle),
          ),
          const SizedBox(height: 5.0),
        ],
      ),
    );
  }
}
