import 'package:alarm/alarm.dart';
import 'package:easy_alarm/common/tools.dart';
import 'package:easy_alarm/core/ez_path.dart';
import 'package:easy_alarm/core/route.dart';
import 'package:easy_alarm/modules/alarm/bloc/ringing/ringing_bloc.dart';
import 'package:easy_alarm/modules/alarm/bloc/ringing/ringing_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';

class EzRingPage extends StatelessWidget {
  const EzRingPage({super.key, required this.state});

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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(),
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
                    padding: EdgeInsets.symmetric(horizontal: 37.0.w),
                    child: LottieBuilder.asset("assets/lotties/alarm_ringing.json"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state.alarm.snoozeDuration != null) ...[
                        GestureDetector(
                          onTap: () => _onTapWaitAlarmButton(context, state.alarm.snoozeDuration),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0.r),
                              color: theme.colorScheme.background,
                              border: Border.all(color: theme.colorScheme.outlineVariant),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 18.0.h, horizontal: 11.0.w),
                            child: Text(
                              "alarm.waitForNext".tr(),
                              style: theme.textTheme.labelLarge?.copyWith(color: theme.disabledColor),
                            ),
                          ),
                        ),
                        SizedBox(width: 33.0.w),
                      ],
                      GestureDetector(
                        onTap: () => _onTapCloseAlarmButton(context),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0.r),
                            boxShadow: [
                              BoxShadow(offset: Offset(0.0.w, 4.0.h), blurRadius: 4.0.r, color: Colors.black26),
                            ],
                            color: theme.colorScheme.primary,
                            border: Border.all(color: theme.colorScheme.outlineVariant),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 18.0.h, horizontal: 32.0.w),
                          child: Text(
                            "alarm.closeAlarm".tr(),
                            style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onPrimary),
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

  void _onTapWaitAlarmButton(BuildContext context, int? totalMinute) {
    context.loaderOverlay.show();
    context.read<RingingBloc>().waitForSnooze().then((_) {
      context.loaderOverlay.hide();
      if ((totalMinute ?? 0) > 60) {
        final int hour = totalMinute! ~/ 60;
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
      mainNavKey.currentContext!.replaceNamed(EzPath.alarm);
    });
  }

  void _onTapCloseAlarmButton(BuildContext context) {
    context.loaderOverlay.show();
    context.read<RingingBloc>().stopAlarm().then((_) {
      context.loaderOverlay.hide();
      mainNavKey.currentContext!.replaceNamed(EzPath.alarm);
    });
  }
}
