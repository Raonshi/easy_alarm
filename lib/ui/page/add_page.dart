import 'package:easy_alarm/bloc/add/add_bloc.dart';
import 'package:easy_alarm/bloc/add/add_bloc_state.dart';
import 'package:easy_alarm/common/enums.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:easy_alarm/ui/widget/alarm_content_panel_widget.dart';
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("addAlarm.header".tr(), style: _topButtonTextStyle),
          actions: [
            GestureDetector(
              onTap: () {
                context.read<AddBloc>().save().then((value) => Navigator.pop(context));
              },
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
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: AlarmContentPanelWidget(
                          onChangedTitle: context.read<AddBloc>().updateTitle,
                          onChangedContent: context.read<AddBloc>().updateContent,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TimerPanelWidget(
                          time: TimeOfDay(
                            hour: state.alarmModel.time.hour,
                            minute: state.alarmModel.time.minute,
                          ),
                          onTimeChanged: context.read<AddBloc>().updateTime,
                        ),
                      ),
                      const Divider(height: 2.0, thickness: 2.0, color: CustomColors.grey10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: RoutinePanelWidget(
                          selectedWeekdays: state.alarmModel.weekdays,
                          onTapSwitch: (bool value) {
                            if (!value) context.read<AddBloc>().updateWeekdays([]);
                          },
                          onSelectedDaysChanged: (List<Weekday> weekdays) {
                            context.read<AddBloc>().updateWeekdays(weekdays);
                          },
                        ),
                      ),
                      const Divider(height: 2.0, thickness: 2.0, color: CustomColors.grey10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SnoozePanelWidget(
                          snoozeTime: TimeOfDay(
                            hour: state.alarmModel.snoozeTime?.hour ?? 0,
                            minute: state.alarmModel.snoozeTime?.minute ?? 0,
                          ),
                          onTapSwitch: (bool value) {
                            if (!value) context.read<AddBloc>().updateSnoozeTime();
                          },
                          onDurationChanged: (Duration? value) {
                            if (value != null) {
                              context.read<AddBloc>().updateSnoozeTime(value);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 5.0),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
