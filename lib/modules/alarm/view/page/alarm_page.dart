import 'package:alarm/alarm.dart';
import 'package:easy_alarm/common/tools.dart';
import 'package:easy_alarm/core/route.dart';
import 'package:easy_alarm/modules/alarm/bloc/ringing/ringing_bloc.dart';
import 'package:easy_alarm/modules/alarm/bloc/ringing/ringing_state.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key, required this.state});

  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => RingingBloc(state.extra as AlarmSettings),
      child: const _AlarmPageBody(),
    );
  }
}

class _AlarmPageBody extends StatelessWidget {
  const _AlarmPageBody();

  TextStyle get _waitForNextAlarmTextStyle => const TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        height: 1.0,
        color: CustomColors.grey50,
      );

  TextStyle get _closeAlarmTextStyle => const TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        height: 1.0,
        color: CustomColors.black,
      );

  BoxDecoration get _waitForNextAlarmDecoration => BoxDecoration(
        color: CustomColors.grey10,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: CustomColors.grey30),
      );

  BoxDecoration get _closeButtonDecoration => BoxDecoration(
        color: CustomColors.blue30,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: CustomColors.grey30),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0.0, 4.0),
            blurRadius: 4.0,
            color: CustomColors.black.withOpacity(0.25),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.grey10,
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: CustomColors.grey10,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<RingingBloc, RingingState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const Offstage(),
            loading: (_) => const Center(child: CircularProgressIndicator.adaptive()),
            error: (state) => Center(child: Text(state.exception.toString())),
            loaded: (state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 37.0),
                    child: LottieBuilder.asset("assets/lotties/alarm_ringing.json"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => context.read<RingingBloc>().waitForSnooze().then((totalMinute) {
                          if (totalMinute > 60) {
                            final int hour = totalMinute ~/ 60;
                            final int minute = totalMinute % 60;
                            if (minute == 0) {
                              showSnackBar("alarm.nextAlarmSnackbarHour".tr(args: [hour.toString()]));
                            } else {
                              showSnackBar(
                                "alarm.nextAlarmSnackbarHourMinute".tr(args: [hour.toString(), minute.toString()]),
                              );
                            }
                          } else {
                            showSnackBar("alarm.nextAlarmSnackbarMinute".tr(args: [totalMinute.toString()]));
                          }
                          mainNavKey.currentContext!.replaceNamed(Path.home.path);
                        }),
                        child: Expanded(
                          child: Container(
                            decoration: _waitForNextAlarmDecoration,
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child: Text("alarm.waitForNext".tr(), style: _waitForNextAlarmTextStyle),
                          ),
                        ),
                      ),
                      const SizedBox(width: 53.0),
                      GestureDetector(
                        onTap: () => context
                            .read<RingingBloc>()
                            .stopAlarm()
                            .then((value) => mainNavKey.currentContext!.replaceNamed(Path.home.path)),
                        child: Expanded(
                          child: Container(
                            decoration: _closeButtonDecoration,
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child: Text("alarm.closeAlarm".tr(), style: _closeAlarmTextStyle),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
