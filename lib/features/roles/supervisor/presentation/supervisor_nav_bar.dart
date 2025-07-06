// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:go_router/go_router.dart';

class SupervisorBottomNavBar extends StatefulWidget {
  const SupervisorBottomNavBar({super.key, required this.child});
  final Widget child;
  @override
  State<SupervisorBottomNavBar> createState() => _SupervisorBottomNavBarState();
}

class _SupervisorBottomNavBarState extends State<SupervisorBottomNavBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: widget.child,
        bottomNavigationBar: Directionality(
          textDirection: TextDirection.ltr,
          child: BottomNavigationBar(
            backgroundColor: AppColors.primary,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: (index) => changeTab(index),
            selectedItemColor: AppColors.secondary,
            unselectedItemColor: AppColors.white,
            showUnselectedLabels: false,
            showSelectedLabels: true,
            iconSize: 26.0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.file_open_outlined),
                label: 'الأعذار',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notification_important_outlined),
                label: 'الأشعارات',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                label: 'حسابي',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeTab(int index) async {
    switch (index) {
      case 0:
        context.go(AppRoutes.supervisorHome);
        setState(() {
          selectedIndex = 0;
        });
        break;
      case 1:
        context.go(AppRoutes.supervisorExcuseDetails);
        setState(() {
          selectedIndex = 1;
        });
        break;
      case 2:
        context.go(AppRoutes.supervisorNotifications);
        setState(() {
          selectedIndex = 2;
        });
        break;
      case 3:
        context.go(AppRoutes.supervisorProfilePage);
        setState(() {
          selectedIndex = 3;
        });
        break;
      default:
        break;
    }
  }
}
