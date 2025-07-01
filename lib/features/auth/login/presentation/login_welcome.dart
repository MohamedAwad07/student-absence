import 'package:flutter/material.dart';
import 'package:student_absence/core/utils/app_assets.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/features/auth/login/presentation/login_logo.dart';
import 'package:student_absence/core/utils/app_strings.dart';

class LoginWelcomeScreen extends StatelessWidget {
  const LoginWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              const LoginLogo(
                iconColor: AppColors.white,
                iconPath: Assets.assetsImagesLogoLogoGreen,
              ),
              const SizedBox(height: 24),
              const Text(
                AppStrings.welcome,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                AppStrings.systemTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        AppStrings.systemDescription,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 2),
                    InfoItem(text: AppStrings.featureEasySubmission),
                    InfoItem(text: AppStrings.featureTrackStatus),
                    InfoItem(text: AppStrings.featureInstantNotifications),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Buttons
              CustomWelcomeButton(
                label: AppStrings.studentLogin,
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              const SizedBox(height: 12),
              CustomWelcomeButton(
                label: AppStrings.supervisorLogin,
                backgroundColor: AppColors.secondary,
                textColor: Colors.black87,
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              const SizedBox(height: 12),
              CustomWelcomeButton(
                label: AppStrings.facultyLogin,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                borderColor: AppColors.primary,
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Info line with check icon
class InfoItem extends StatelessWidget {
  final String text;
  const InfoItem({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 64),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        const SizedBox(width: 8),
        const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
        const SizedBox(width: 64),
      ],
    );
  }
}

class CustomWelcomeButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  const CustomWelcomeButton({
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: borderColor != null
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
