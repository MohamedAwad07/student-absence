import 'package:flutter/material.dart';

class SupervisorProfilePage extends StatelessWidget {
  const SupervisorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Supervisor Profile Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
