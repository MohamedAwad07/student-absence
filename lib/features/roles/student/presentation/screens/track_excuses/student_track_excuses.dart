import 'package:flutter/material.dart';

class StudentTrackExcuses extends StatelessWidget {
  const StudentTrackExcuses({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Student Track Excuses Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
