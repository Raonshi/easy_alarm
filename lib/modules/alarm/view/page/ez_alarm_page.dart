import 'package:easy_alarm/common/tools.dart';
import 'package:easy_alarm/core/bloc/alarms/alarms_bloc.dart';
import 'package:easy_alarm/core/bloc/alarms/alarms_state.dart';
import 'package:easy_alarm/core/ez_path.dart';
import 'package:easy_alarm/core/route.dart';
import 'package:easy_alarm/modules/main/bloc/theme_bloc.dart';
import 'package:easy_alarm/modules/home/view/widget/alarm_item_widget.dart';
import 'package:easy_alarm/style/icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/svg.dart';

class EzAlarmPage extends StatelessWidget {
  const EzAlarmPage({super.key, required this.state});

  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => AlarmsBloc(),
      child: const _HomePageBody(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final themeBloc = context.read<ThemeBloc>();

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        centerTitle: false,
        surfaceTintColor: theme.colorScheme.background,
        title: Text(
          'header.alarm'.tr(),
          style: theme.textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (themeBloc.state == ThemeMode.dark) {
                context.read<ThemeBloc>().changeTheme(ThemeMode.light);
              } else {
                context.read<ThemeBloc>().changeTheme(ThemeMode.dark);
              }
            },
            icon: SvgPicture.asset(
              themeBloc.state == ThemeMode.dark ? CustomIcons.sun : CustomIcons.moon,
              width: 24.0.w,
              height: 24.0.h,
              colorFilter: ColorFilter.mode(theme.colorScheme.onBackground, BlendMode.srcIn),
            ),
          ),
          IconButton(
            onPressed: () {
              mainNavKey.currentContext!.pushNamed(EzPath.add).then((value) {
                context.read<AlarmsBloc>().refreshAlarms();
              });
            },
            icon: SvgPicture.asset(
              CustomIcons.add,
              width: 24.0.w,
              height: 24.0.h,
              colorFilter: ColorFilter.mode(theme.colorScheme.onBackground, BlendMode.srcIn),
            ),
          ),
          SizedBox(width: 20.0.w),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<AlarmsBloc, AlarmsState>(
          builder: (context, state) {
            return state.map(
              initial: (_) => const Offstage(),
              loading: (_) => const Center(child: CircularProgressIndicator.adaptive()),
              error: (state) => Center(child: Text(state.exception.toString())),
              loaded: (state) {
                if (state.alarms.isEmpty) {
                  return Center(
                    child: Text(
                      "home.noAlarm".tr(),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(color: theme.disabledColor),
                    ),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<AlarmsBloc>().refreshAlarms();
                    },
                    child: ListView.separated(
                      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 12.0.h, bottom: 48.0.h),
                      itemCount: state.alarms.length,
                      itemBuilder: (context, index) {
                        return AlarmItemWidget(
                          key: ValueKey(state.alarms[index].id),
                          item: state.alarms[index],
                          onTapDelete: context.read<AlarmsBloc>().deleteAlarm,
                          onTapSwitch: (int groupId) {
                            context.read<AlarmsBloc>().toggleAlarm(groupId);
                            final String msg =
                                state.alarms[index].isEnabled ? "home.alarmDisabled".tr() : "home.alarmEnabled".tr();
                            showSnackBar(msg);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 16.0.h),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
