import 'package:easy_alarm/bloc/add/add_bloc.dart';
import 'package:easy_alarm/bloc/add/add_bloc_state.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:easy_alarm/ui/widget/routine_panel_widget.dart';
import 'package:easy_alarm/ui/widget/snooze_panel_widget.dart';
import 'package:easy_alarm/ui/widget/timer_panel_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddBloc(),
      child: const _AddPageBody(),
    );
  }
}

class _AddPageBody extends StatelessWidget {
  const _AddPageBody();

  TextStyle get _topButtonTextStyle =>
      const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: CustomColors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("addAlarm.header".tr(), style: _topButtonTextStyle),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Text("common.complete".tr(), style: _topButtonTextStyle),
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: BlocBuilder<AddBloc, AddBlocState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const Offstage(),
            loading: (_) => const Center(child: CircularProgressIndicator.adaptive()),
            error: (state) => Center(child: Text(state.exception.toString())),
            loaded: (state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
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
                      // child: Text("alarm.snoozeLabel".tr(), style: _labelTextStyle),
                      child: SnoozePanelWidget(),
                    ),
                    const SizedBox(height: 5.0),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
