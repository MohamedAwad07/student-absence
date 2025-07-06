// ignore_for_file: depend_on_referenced_packages

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:go_router/go_router.dart';

class ManagerBottomNavBar extends StatefulWidget {
  const ManagerBottomNavBar({super.key, required this.child});
  final Widget child;
  @override
  State<ManagerBottomNavBar> createState() => _ManagerBottomNavBarState();
}

class _ManagerBottomNavBarState extends State<ManagerBottomNavBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<TabItem> items = [
      const TabItem(icon: Icons.home_outlined),
      const TabItem(icon: Icons.file_open_outlined),
      const TabItem(icon: Icons.check_circle_outline),
      const TabItem(icon: Icons.notification_important_outlined),
      const TabItem(icon: Icons.person_2_outlined),
    ];

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: widget.child,
        bottomNavigationBar: Directionality(
          textDirection: TextDirection.ltr,
          child: BottomBarCreative(
            items: items,
            bottom: 5.h,
            blur: 0,
            enableShadow: false,
            iconSize: 30.sp,
            pad: 0,
            paddingVertical: 0,
            backgroundColor: AppColors.primary,
            color: AppColors.white,
            colorSelected: AppColors.secondary,
            indexSelected: selectedIndex,
            isFloating: true,
            highlightStyle: const HighlightStyle(
              sizeLarge: true,
              isHexagon: true,
              elevation: 2,
            ),
            onTap: (int index) => setState(() {
              changeTab(index);
            }),
          ),
        ),
      ),
    );
  }

  void changeTab(int index) async {
    switch (index) {
      case 0:
        context.go(AppRoutes.managerHome);
        setState(() {
          selectedIndex = 0;
        });
        break;
      case 1:
        context.go(AppRoutes.managerRevisedExcuses);
        setState(() {
          selectedIndex = 1;
        });
        break;

      case 2:
        context.go(AppRoutes.managerExcuseDetails);
        setState(() {
          selectedIndex = 2;
        });
        break;
      case 3:
        context.go(AppRoutes.managerNotifications);
        setState(() {
          selectedIndex = 3;
        });
        break;
      case 4:
        context.go(AppRoutes.managerProfilePage);
        setState(() {
          selectedIndex = 4;
        });
        break;
      default:
        break;
    }
  }
}
