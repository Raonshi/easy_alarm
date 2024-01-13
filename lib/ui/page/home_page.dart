import 'package:easy_alarm/common/dummy.dart';
import 'package:easy_alarm/ui/page/add_page.dart';
import 'package:easy_alarm/ui/widget/add_new_alarm_widget.dart';
import 'package:easy_alarm/ui/widget/alarm_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  TextStyle get _headerTextStyle => const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle get _addBtnTextStyle => const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('header.home'.tr(), style: _headerTextStyle),
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPage())),
            child: Text("common.add".tr(), style: _addBtnTextStyle),
          ),
          SizedBox(width: 20.0),
        ],
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
              itemCount: dummyAlarms.length,
              itemBuilder: (context, index) {
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
