import 'package:easy_alarm/common/tools.dart';
import 'package:easy_alarm/core/calendar_manager.dart';
import 'package:easy_alarm/modules/calendar/bloc/ez_calendar_bloc.dart';
import 'package:easy_alarm/modules/calendar/bloc/ez_calendar_state.dart';
import 'package:easy_alarm/modules/calendar/model/ez_calendar_model.dart';
import 'package:easy_alarm/modules/calendar/view/widget/ez_calendar.dart';
import 'package:easy_alarm/modules/calendar/view/widget/ez_calendar_event_dialog.dart';
import 'package:easy_alarm/modules/main/bloc/theme_bloc.dart';
import 'package:easy_alarm/style/icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class EzCalendarPage extends StatelessWidget {
  const EzCalendarPage({super.key, required this.state});

  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => EzCalendarBloc(),
      child: const _EzCalendarPageBody(),
    );
  }
}

class _EzCalendarPageBody extends StatelessWidget {
  const _EzCalendarPageBody();

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
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: EzCalendar(
              events: EzCalendarManager().events,
              onAddEvent: (DateTime value) {
                showDialog(
                  context: context,
                  builder: (context) => const EzCalendarEventDialog(),
                );
              },
              onDaySelected: (List<EzCalendarEvent> value) {
                context.read<EzCalendarBloc>().updateEvents(value);
              },
            ),
          ),
        ],
        body: BlocBuilder<EzCalendarBloc, EzCalendarState>(builder: (context, state) {
          return state.map(
            initial: (_) => const Offstage(),
            loading: (_) => const Center(child: CircularProgressIndicator()),
            error: (state) => Center(child: Text(state.exception.toString())),
            loaded: (state) {
              return ListView.builder(
                itemCount: state.events.length,
                itemBuilder: (context, index) {
                  final EzCalendarEvent event = state.events[index];
                  return ListTile(
                    title: Text(event.title),
                    subtitle: Text(event.subtitle),
                    leading: Checkbox(
                      value: true,
                      onChanged: (value) {},
                    ),
                    trailing: const Icon(Icons.archive),
                    onTap: () {
                      showSnackBar('Item $index');
                    },
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}
