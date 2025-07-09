import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/utils/nav_bar_cubit.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_absence/features/roles/supervisor/presentation/controller/supervisor_cubit/supervisor_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SupervisorRevisedExcusesPage extends StatefulWidget {
  const SupervisorRevisedExcusesPage({super.key});

  @override
  State<SupervisorRevisedExcusesPage> createState() => _SupervisorRevisedExcusesPageState();
}

class _SupervisorRevisedExcusesPageState extends State<SupervisorRevisedExcusesPage> {
  @override
  void initState() {
    super.initState();
    final supervisorId = FirebaseAuth.instance.currentUser?.uid;
    if (supervisorId != null) {
      context.read<SupervisorCubit>().getRevisedExcuses(supervisorId);
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
              context.go(AppRoutes.supervisorProfilePage);
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
                  // Section Title
                  const Text(
                    'الأعذار التي تمت مراجعتها من جهتك',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.primary,
                    ),
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
  Color _statusColor(String status) {
    switch (status) {
      case 'مقبول':
        return AppColors.primary;
      case 'بإنتظار القرار النهائي':
        return AppColors.secondary;
      case 'مرفوض':
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupervisorCubit, SupervisorState>(
      builder: (context, state) {
        if (state is SupervisorLoading) {
          return Skeletonizer(
            enabled: true,
            child: Column(
              children: List.generate(3, (index) => _ExcuseSkeletonCard()),
            ),
          );
        } else if (state is SupervisorRevisedExcusesLoaded) {
          final excuses = state.excuses;
          if (excuses.isEmpty) {
            return const Center(child: Text('لا توجد أعذار تمت مراجعتها'));
          }
          return Column(
            children: excuses.map((excuse) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          excuse.studentName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'رقم الطالب: ${excuse.studentAcademicNumber}',
                          style: const TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'نوع العذر: ${excuse.type}',
                          style: const TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'تاريخ التقديم: ${excuse.createdAt.toString().split(' ')[0]}',
                          style: const TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                      ],
                    ),
                    const Spacer(),
                    _StatusChip(
                      status: excuse.status,
                      color: _statusColor(excuse.status),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        } else if (state is SupervisorError) {
          return Center(child: Text(state.failure.message));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  final Color color;
  const _StatusChip({required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _ExcuseSkeletonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton.leaf(
                child: Container(
                  width: 100,
                  height: 18,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 2),
              Skeleton.leaf(
                child: Container(
                  width: 120,
                  height: 14,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 2),
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
                  width: 140,
                  height: 14,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
          const Spacer(),
          Skeleton.leaf(
            child: Container(
              width: 60,
              height: 18,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }
}
