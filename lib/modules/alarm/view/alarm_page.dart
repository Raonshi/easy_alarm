import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key, required this.state});

  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          const Text(
            'Alarm',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () async {
              await Alarm.stopAll();
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}
