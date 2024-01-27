import 'package:easy_alarm/modules/main/view/widget/bottom_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellPage extends StatelessWidget {
  const ShellPage({super.key, required this.state, required this.child});

  final GoRouterState state;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(child: child),
          const BottomAdWidget(),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
