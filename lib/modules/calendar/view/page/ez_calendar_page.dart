import 'package:easy_alarm/common/tools.dart';
import 'package:easy_alarm/modules/main/bloc/theme_bloc.dart';
import 'package:easy_alarm/style/icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

class EzCalendarPage extends StatelessWidget {
  const EzCalendarPage({super.key, required this.state});

  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final themeBloc = context.read<ThemeBloc>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('header.calendar'.tr()),
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
              width: 24.0,
              height: 24.0,
              colorFilter: ColorFilter.mode(colors.onBackground, BlendMode.srcIn),
            ),
          ),
          IconButton(
            onPressed: () {
              showSnackBar("exception.notImplemented".tr());
            },
            icon: SvgPicture.asset(
              CustomIcons.add,
              width: 24.0,
              height: 24.0,
              colorFilter: ColorFilter.mode(colors.onBackground, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime(1900),
        lastDay: DateTime(2099),
      ),
    );
  }
}
