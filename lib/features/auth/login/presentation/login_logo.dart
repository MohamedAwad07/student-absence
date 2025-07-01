import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  final Color iconColor;
  final String iconPath;
  const LoginLogo({super.key, required this.iconColor, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 120,
        height: 120,
        decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
        child: Image.asset(iconPath, fit: BoxFit.fill),
      ),
    );
  }
}
