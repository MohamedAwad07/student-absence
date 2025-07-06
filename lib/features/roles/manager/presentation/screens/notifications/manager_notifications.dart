import 'package:flutter/material.dart';

class ManagerNotificationsPage extends StatelessWidget {
  const ManagerNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Manager Notifications Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
