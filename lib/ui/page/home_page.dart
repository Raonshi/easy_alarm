import 'package:easy_alarm/bloc/alarms/alarms_bloc.dart';
import 'package:easy_alarm/bloc/alarms/alarms_state.dart';
import 'package:easy_alarm/common/dummy.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:easy_alarm/ui/page/add_page.dart';
import 'package:easy_alarm/ui/widget/alarm_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AlarmsBloc(), child: const _HomePageBody());
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({super.key});

  TextStyle get _headerTextStyle => const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle get _addBtnTextStyle => const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle get _emptyTextStyle =>
      const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: CustomColors.grey50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('header.home'.tr(), style: _headerTextStyle),
        actions: [
          GestureDetector(
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPage()));
            },
            child: Text("common.add".tr(), style: _addBtnTextStyle),
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<AlarmsBloc, AlarmsState>(
            builder: (context, state) {
              return state.map(
                initial: (_) => const Offstage(),
                loading: (_) => const Center(child: CircularProgressIndicator.adaptive()),
                error: (state) => Center(child: Text(state.exception.toString())),
                loaded: (state) {
                  if (state.alarmModels.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          "home.noAlarm".tr(),
                          textAlign: TextAlign.center,
                          style: _emptyTextStyle,
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 12.0,
                          bottom: 48.0,
                        ),
                        itemCount: state.alarmModels.length,
                        itemBuilder: (context, index) {
                          return AlarmItemWidget(
                            item: state.alarmModels[index],
                            onTapDelete: (String value) {},
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 16.0),
                      ),
                    );
                  }
                },
              );
            },
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
