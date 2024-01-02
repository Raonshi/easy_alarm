import 'package:easy_alarm/common/dummy.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:easy_alarm/style/icons.dart';
import 'package:easy_alarm/ui/widget/alarm_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
                  return Container(
                    decoration: ShapeDecoration(
                      shadows: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 4.0,
                          spreadRadius: 0.0,
                          color: Colors.black.withOpacity(0.25),
                        )
                      ],
                      color: CustomColors.blue10,
                      shape: const CircleBorder(
                        side: BorderSide(color: CustomColors.blue20),
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      CustomIcons.add,
                      colorFilter: const ColorFilter.mode(CustomColors.blue70, BlendMode.srcIn),
                    ),
                  );
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
