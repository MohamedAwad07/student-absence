// ignore_for_file: depend_on_referenced_packages

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_absence/core/utils/nav_bar_cubit.dart';
import 'package:student_absence/features/roles/manager/presentation/controller/manager_cubit/manager_cubit.dart';

class ManagerBottomNavBar extends StatelessWidget {
  const ManagerBottomNavBar({super.key, required this.child, this.unreadNotificationsCount});
  final Widget child;
  final int? unreadNotificationsCount;
  @override
  Widget build(BuildContext context) {
    final List<TabItem> items = [
      const TabItem(icon: Icons.home_outlined),
      const TabItem(icon: Icons.check_circle_outline),
      const TabItem(icon: Icons.file_open_outlined),
      TabItem(
        icon: Icons.notification_important_outlined,
        count: (unreadNotificationsCount ?? 0) > 0
            ? const Icon(Icons.circle, size: 10, color: Colors.red)
            : null,
      ),
      const TabItem(icon: Icons.person_2_outlined),
    ];

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: child,
        bottomNavigationBar: Directionality(
          textDirection: TextDirection.ltr,
          child: BlocBuilder<NavBarCubit, int>(
            builder: (context, selectedIndex) {
              return BottomBarCreative(
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
                onTap: (int index) => _changeTab(context, index),
              );
            },
          ),
        ),
      ),
    );
  }

  void _changeTab(BuildContext context, int index) {
    final cubit = context.read<NavBarCubit>();
    switch (index) {
      case 0:
        context.go(AppRoutes.managerHome);
        cubit.setTab(0);
        break;
      case 1:
        context.go(AppRoutes.managerRevisedExcuses);
        cubit.setTab(1);
        break;
      case 2:
        final managerCubit = context.read<ManagerCubit>();
        final pendingExcuses = managerCubit.pendingExcuses;
        if (pendingExcuses.isNotEmpty) {
          context.go(
            AppRoutes.managerExcuseDetails,
            extra: pendingExcuses.first,
          );
        } else {
          context.go(
            AppRoutes.managerExcuseDetails,
            extra: null,
          );
        }
        cubit.setTab(2);
        break;
      case 3:
        context.go(AppRoutes.managerNotifications);
        cubit.setTab(3);
        break;
      case 4:
        context.go(AppRoutes.managerProfilePage);
        cubit.setTab(4);
        break;
      default:
        break;
    }
  }
}
