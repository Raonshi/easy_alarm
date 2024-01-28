import 'package:easy_alarm/common/tools.dart';
import 'package:easy_alarm/modules/alarm/bloc/add/add_bloc.dart';
import 'package:easy_alarm/modules/alarm/bloc/add/add_state.dart';
import 'package:easy_alarm/modules/alarm/view/widget/sound_panel_widget.dart';
import 'package:easy_alarm/modules/alarm/view/widget/vibrate_panel_widget.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:easy_alarm/modules/alarm/view/widget/routine_panel_widget.dart';
import 'package:easy_alarm/modules/alarm/view/widget/snooze_panel_widget.dart';
import 'package:easy_alarm/modules/alarm/view/widget/timer_panel_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColors.grey10,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          backgroundColor: CustomColors.grey10,
          title: Text("addAlarm.header".tr(), style: _topButtonTextStyle),
          actions: [
            GestureDetector(
              onTap: () {
                context.loaderOverlay.show();
                context.read<AddBloc>().validate().then((value) {
                  context.loaderOverlay.hide();
                  if (value == null) {
                    context.read<AddBloc>().save().then((value) => Navigator.pop(context));
                  } else {
                    showSnackBar(value);
                  }
                });
              },
              child: Text("common.complete".tr(), style: _topButtonTextStyle),
            ),
            const SizedBox(width: 20.0),
          ],
        ),
        body: BlocBuilder<AddBloc, AddState>(
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
                        child: TimerPanelWidget(
                          time: state.alarmGroup.dateTime,
                          onTimeChanged: context.read<AddBloc>().updateTime,
                        ),
                      ),
                      const Divider(height: 2.0, thickness: 2.0, color: CustomColors.grey10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: RoutinePanelWidget(
                          selectedWeekdays: state.alarmGroup.weekdays,
                          onTapSwitch: (bool value) {
                            context.read<AddBloc>().updateWeekdays(value, [DateTime.now().weekday]);
                          },
                          onSelectedDaysChanged: (List<int> weekdays) {
                            context.read<AddBloc>().updateWeekdays(true, weekdays);
                          },
                        ),
                      ),
                      const Divider(height: 2.0, thickness: 2.0, color: CustomColors.grey10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SnoozePanelWidget(
                          snoozeTime: TimeOfDay(
                            hour: state.alarmGroup.snoozeMinute != null ? state.alarmGroup.snoozeMinute! ~/ 60 : 0,
                            minute: state.alarmGroup.snoozeMinute != null ? state.alarmGroup.snoozeMinute! % 60 : 0,
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
                      const Divider(height: 2.0, thickness: 2.0, color: CustomColors.grey10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SoundPanelWidget(
                          onSelectSound: context.read<AddBloc>().updateSound,
                        ),
                      ),
                      const Divider(height: 2.0, thickness: 2.0, color: CustomColors.grey10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: VibratePanelWidget(
                          onTapSwitch: context.read<AddBloc>().updateVibration,
                        ),
                      ),
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
