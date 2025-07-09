import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/core/utils/nav_bar_cubit.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_absence/features/auth/controller/auth_cubit/auth_cubit.dart';
import 'package:student_absence/features/roles/student/presentation/controller/student_cubit/student_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<AuthCubit>().currentUser;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          StudentHomeAppBar(
            profileOnPressed: () {
              context.go(AppRoutes.studentProfilePage);
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
                children: [
                  // Profile Section
                  Column(
                    children: [
                      const CircleAvatar(
                        radius: 36,
                        backgroundColor: Color(0xFFD4A63A),
                        child: Icon(
                          Icons.person,
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        userModel?.name ?? "غير معروف",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'رقم الطالب: ${userModel?.academicNumber}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Summary Cards (static for now)
                  BlocBuilder<StudentCubit, StudentState>(
                    builder: (context, state) {
                      final isLoading = state is StudentLoading;
                      int accepted = 0;
                      int pending = 0;
                      int rejected = 0;
                      if (state is StudentExcusesLoaded) {
                        accepted = state.excuses
                            .where((e) => e.status == 'مقبولة')
                            .length;
                        pending = state.excuses
                            .where((e) => e.status == 'قيد المراجعة')
                            .length;
                        rejected = state.excuses
                            .where((e) => e.status == 'مرفوضة')
                            .length;
                      }
                      return Skeletonizer(
                        enabled: isLoading,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _SummaryCard(
                              count: accepted,
                              label: 'مقبولة',
                              color: const Color(0xFF4CAF50),
                            ),
                            _SummaryCard(
                              count: pending,
                              label: 'قيد المراجعة',
                              color: const Color(0xFFFFC107),
                            ),
                            _SummaryCard(
                              count: rejected,
                              label: 'مرفوضة',
                              color: const Color(0xFFF44336),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 18),
                  // Latest Excuses
                  _SectionTitle(
                    title: 'ملخص الأعذار',
                    onPressed: () {
                      context.go(AppRoutes.studentTrackExcuses);
                      context.read<NavBarCubit>().setTab(1);
                    },
                  ),
                  const SizedBox(height: 8),
                  BlocBuilder<StudentCubit, StudentState>(
                    builder: (context, state) {
                      final isLoading = state is StudentLoading;
                      if (state is StudentExcusesLoaded) {
                        final excuses = state.excuses.toList()
                          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
                        final latestExcuses = excuses.take(3).toList();
                        if (latestExcuses.isEmpty) {
                          return const Center(child: Text('لا توجد أعذار بعد'));
                        }
                        return Skeletonizer(
                          enabled: false,
                          child: Column(
                            children: latestExcuses.map((excuse) {
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.description,
                                    color: _statusColor(excuse.status),
                                  ),
                                  title: Text(
                                    excuse.reason,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'تاريخ التقديم: ${excuse.createdAt.toString().split(' ').first}',
                                  ),
                                  trailing: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _statusColor(
                                        excuse.status,
                                      ).withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      excuse.status,
                                      style: TextStyle(
                                        color: _statusColor(excuse.status),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      } else if (isLoading) {
                        return Skeletonizer(
                          enabled: true,
                          child: Column(
                            children: List.generate(
                              3,
                              (index) => Card(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  leading: const Icon(Icons.description),
                                  title: const Text('عنوان العذر'),
                                  subtitle: const Text(
                                    'تاريخ التقديم: 2023-01-01',
                                  ),
                                  trailing: Container(
                                    width: 48,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (state is StudentError) {
                        return Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 18),
                  // Notifications (static for now)
                  _SectionTitle(
                    title: 'الإشعارات',
                    onPressed: () {
                      context.go(AppRoutes.studentNotifications);
                      context.read<NavBarCubit>().setTab(3);
                    },
                  ),
                  const SizedBox(height: 8),
                  _NotificationList(),
                  const SizedBox(height: 24),
                  // Settings Button
                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        context.go(AppRoutes.studentProfilePage);
                        context.read<NavBarCubit>().setTab(4);
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Color(0xFF225A2A),
                      ),
                      label: const Text(
                        'الإعدادات',
                        style: TextStyle(color: Color(0xFF225A2A)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final int count;
  final String label;
  final Color color;
  const _SummaryCard({
    required this.count,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const _SectionTitle({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF225A2A),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: onPressed,
            child: const Text(
              "عرض الكل",
              style: TextStyle(color: AppColors.secondary),
            ),
          ),
        ],
      ),
    );
  }
}

Color _statusColor(String status) {
  switch (status) {
    case 'مقبولة':
      return const Color(0xFF4CAF50);
    case 'قيد المراجعة':
      return const Color(0xFFFFC107);
    case 'مرفوضة':
      return const Color(0xFFF44336);
    default:
      return Colors.grey;
  }
}

class _NotificationList extends StatelessWidget {
  final List<Map<String, String>> notifications = const [
    {'text': 'تم قبول عذرك الطبي', 'date': '2023-04-16'},
    {'text': 'تم رفض عذر غياب محاضرة الشبكات', 'date': '2023-04-12'},
    {'text': 'تم تحديث حالة عذر غياب محاضرة البرمجة', 'date': '2023-04-11'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: notifications.map((notif) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: const Icon(Icons.notifications, color: Color(0xFF225A2A)),
            title: Text(
              notif['text']!,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text('بتاريخ: ${notif['date']}'),
          ),
        );
      }).toList(),
    );
  }
}
