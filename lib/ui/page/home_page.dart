import 'package:easy_alarm/common/dummy.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:easy_alarm/ui/widget/add_alarm_bottom_sheet.dart';
import 'package:easy_alarm/ui/widget/add_new_alarm_widget.dart';
import 'package:easy_alarm/ui/widget/alarm_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('header.home'.tr()),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 12.0,
                bottom: 48.0,
              ),
              itemCount: dummyAlarms.length + 1,
              itemBuilder: (context, index) {
                if (index == dummyAlarms.length) {
                  return AddNewAlarmWidget(onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: CustomColors.white,
                      isScrollControlled: true,
                      showDragHandle: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28.0),
                          topRight: Radius.circular(28.0),
                        ),
                      ),
                      builder: (context) => const AddAlarmBottomSheet(),
                    );
                  });
                }
                return AlarmItemWidget(
                  item: dummyAlarms[index],
                  onTapDelete: (String value) {},
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16.0),
            ),
          ),
          Container(
            height: 90.0,
            color: Colors.grey,
            child: const Center(child: Text("Ads")),
          ),
        ],
      ),
    );
  }
}
