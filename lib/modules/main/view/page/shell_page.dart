import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ShellPage extends StatelessWidget {
  const ShellPage({super.key, required this.state, required this.child});

  final GoRouterState state;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Material(
        child: Column(
          children: [
            Expanded(child: child),
            // const BottomAdWidget(),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
