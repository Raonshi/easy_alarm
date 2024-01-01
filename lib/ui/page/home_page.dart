import 'package:easy_alarm/ui/widget/alarm_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home.header'.tr()),
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
              itemCount: 100 + 1,
              itemBuilder: (context, index) {
                if (index == 100) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.add),
                  );
                }
                return AlarmItemWidget();
              },
              separatorBuilder: (context, index) => SizedBox(height: 16.0),
            ),
          ),
          Container(
            height: 90.0,
            color: Colors.grey,
            child: Center(child: Text("Ads")),
          ),
        ],
      ),
    );
  }
}
