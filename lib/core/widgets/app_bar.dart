import 'package:flutter/material.dart';
import 'package:student_absence/core/utils/app_assets.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/core/utils/app_strings.dart';

class BuildCustomAppBar extends StatelessWidget {
  final VoidCallback profileOnPressed;
  final bool fromProfile;
  const BuildCustomAppBar({
    super.key,
    required this.profileOnPressed,
    this.fromProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColors.primary,
      expandedHeight: 60,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 24),
          Row(
            children: [
              Image.asset(
                Assets.assetsImagesLogoLogoGold,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 12),
              const Text(
                AppStrings.appName,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          fromProfile == true
              ? const SizedBox.shrink()
              : IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 38,
                  ),
                  onPressed: profileOnPressed,
                ),
        ],
      ),
    );
  }
}
