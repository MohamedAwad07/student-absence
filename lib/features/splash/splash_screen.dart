import 'package:flutter/material.dart';
import 'package:student_absence/core/utils/app_assets.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/core/utils/app_strings.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      setState(() {
        _opacity = 1.0;
      });
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      _navigateToLogin();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 800),
              child: Image.asset(
                Assets.assetsImagesLogoLogoGreen,
                height: 140,
                width: 140,
              ),
            ),
          ),
          const SizedBox(height: 16),
          AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 800),
            child: const Text(
              AppStrings.appName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),
          ),
          const Spacer(),
          AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 800),
            child: const Text(AppStrings.copyright),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // void _navigateToHome() {
  //   Future.delayed(const Duration(seconds: 2), () {
  //     if (!mounted) return;
  //     setState(() {
  //       _opacity = 0.0;
  //     });
  //     Future.delayed(const Duration(milliseconds: 800), () {
  //       if (!mounted) return;
  //       Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  //     });
  //   });
  // }

  void _navigateToLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        _opacity = 0.0;
      });
      Future.delayed(const Duration(milliseconds: 800), () {
        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/loginWelcome',
          (route) => false,
        );
      });
    });
  }
}
