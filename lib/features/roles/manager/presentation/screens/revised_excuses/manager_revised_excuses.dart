import 'package:flutter/material.dart';
import 'package:student_absence/core/utils/nav_bar_cubit.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_absence/features/roles/manager/presentation/controller/manager_cubit/manager_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';

class ManagerRevisedExcusesPage extends StatefulWidget {
  const ManagerRevisedExcusesPage({super.key});

  @override
  State<ManagerRevisedExcusesPage> createState() =>
      _ManagerRevisedExcusesPageState();
}

class _ManagerRevisedExcusesPageState extends State<ManagerRevisedExcusesPage> {
  @override
  void initState() {
    super.initState();
    final managerId = FirebaseAuth.instance.currentUser?.uid;
    if (managerId != null) {
      context.read<ManagerCubit>().getRevisedExcuses(managerId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          BuildCustomAppBar(
            profileOnPressed: () {
              context.go(AppRoutes.managerProfilePage);
              context.read<NavBarCubit>().setTab(4);
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'الأعذار المعالجة',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'قائمة بالأعذار التي تمت معالجتها من قبلك',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 12),
                  _ReviewedExcuseList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewedExcuseList extends StatelessWidget {
  Color statusTextColor(String color) {
    switch (color) {
      case 'مقبول':
        return AppColors.primary;
      case 'مرفوض':
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagerCubit, ManagerState>(
      builder: (context, state) {
        if (state is ManagerLoading) {
          return Skeletonizer(
            enabled: true,
            child: Column(
              children: List.generate(3, (index) => _ExcuseSkeletonCard()),
            ),
          );
        } else if (state is ManagerRevisedExcusesLoaded) {
          final excuses = state.excuses;
          if (excuses.isEmpty) {
            return const Column(
              children: [
                SizedBox(height: 24),
                Center(child: Text('لا توجد أعذار تمت معالجتها')),
              ],
            );
          }
          return Column(
            children: excuses.map((excuse) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "عذر ${excuse.type}",
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                excuse.studentName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                excuse.reason,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              excuse.createdAt.toString().split(' ')[0],
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: 50,
                              height: 24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                excuse.status,
                                style: TextStyle(
                                  color: statusTextColor(excuse.status),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        } else if (state is ManagerError) {
          return Center(child: Text(state.failure.message));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class _ExcuseSkeletonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeleton.leaf(
                      child: Container(
                        width: 120,
                        height: 16,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Skeleton.leaf(
                      child: Container(
                        width: 100,
                        height: 14,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Skeleton.leaf(
                      child: Container(
                        width: 180,
                        height: 12,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Skeleton.leaf(
                  child: Container(
                    width: 80,
                    height: 14,
                    color: Colors.grey[300],
                  ),
                ),
                Skeleton.leaf(
                  child: Container(
                    width: 50,
                    height: 24,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
