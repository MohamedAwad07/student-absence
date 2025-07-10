import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/utils/app_assets.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/utils/app_strings.dart';
import 'package:student_absence/features/auth/login/presentation/login_form.dart';
import 'package:student_absence/features/auth/login/presentation/login_logo.dart';

class LoginScreen extends StatelessWidget {
  final String role;
  const LoginScreen({super.key, required this.role});

  static LoginScreen fromGoRouterState(GoRouterState state) {
    final role = state.pathParameters['role'] ?? 'student';
    return LoginScreen(role: role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 36),
              const LoginLogo(
                iconColor: AppColors.primary,
                iconPath: Assets.assetsImagesLogoLogoGold,
              ),
              const SizedBox(height: 48),
              const LoginForm(),
              RegisterAccountText(role: role),
              const BackToHomeButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterAccountText extends StatelessWidget {
  final String role;
  const RegisterAccountText({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(AppStrings.noAccount),
          TextButton(
            onPressed: () {
              context.push('/register?role=$role');
            },
            child: const Text(
              AppStrings.createAccount,
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

class BackToHomeButton extends StatelessWidget {
  const BackToHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          context.go(AppRoutes.loginWelcome);
        },
        child: const Text(
          AppStrings.backToHome,
          style: TextStyle(color: AppColors.primary, fontSize: 16),
        ),
      ),
    );
  }
}
