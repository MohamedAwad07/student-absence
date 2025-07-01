import 'package:flutter/material.dart';
import 'package:student_absence/core/utils/app_assets.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/core/utils/app_strings.dart';
import 'package:student_absence/features/auth/login/presentation/login_form.dart';
import 'package:student_absence/features/auth/login/presentation/login_logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 32),
              LoginLogo(
                iconColor: AppColors.primary,
                iconPath: Assets.assetsImagesLogoLogoGold,
              ),
              SizedBox(height: 24),
              LoginForm(),
              SizedBox(height: 36),
              BackToHomeButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterPrompt extends StatelessWidget {
  const RegisterPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(AppStrings.noAccount),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text(
            AppStrings.createAccount,
            style: TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}

class BackToHomeButton extends StatelessWidget {
  const BackToHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/loginWelcome',
          (Route<dynamic> route) => false,
        );
      },
      child: const Text(
        AppStrings.backToHome,
        style: TextStyle(color: AppColors.primary, fontSize: 16),
      ),
    );
  }
}
