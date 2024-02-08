import 'package:easy_alarm/core/ez_path.dart';
import 'package:easy_alarm/modules/main/view/widget/bottom_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({super.key, required this.state, required this.child});

  final GoRouterState state;
  final Widget child;

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Material(
        child: Column(
          children: [
            Expanded(child: widget.child),
            const BottomAdWidget(),
            const SizedBox(height: 24.0),
            BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (value) {
                setState(() => _currentIndex = value);
                context.goNamed(value == 0 ? EzPath.alarm : EzPath.calendar);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.alarm),
                  label: "Alarm",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  label: "Calendar",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
