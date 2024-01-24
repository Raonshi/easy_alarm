import 'package:flutter/material.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: const Center(
        child: Text(
          'Alarm',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
