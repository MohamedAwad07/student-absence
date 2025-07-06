import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';

class SupervisorHomePage extends StatelessWidget {
  const SupervisorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          StudentHomeAppBar(profileOnPressed: () {}),
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
                    'الأعذار المراجعة',
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
  final List<Map<String, String>> excuses = const [
    {
      'name': 'أحمد محمد السلام',
      'studentId': '4391052',
      'type': 'سفر',
      'status': 'مقبول',
      'date': '15 صفر 1445',
      'note': '',
    },
    {
      'name': 'أحمد محمد السلام',
      'studentId': '4391052',
      'type': 'برنامج دراسي',
      'status': 'قيد المراجعة',
      'date': '13 صفر 1445',
      'note': '',
    },
    {
      'name': 'أحمد محمد السلام',
      'studentId': '4391052',
      'type': 'مرضية',
      'status': 'مرفوض',
      'date': '12 صفر 1445',
      'note': '',
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'مقبول':
        return AppColors.primary;
      case 'قيد المراجعة':
        return AppColors.secondary;
      case 'مرفوض':
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: excuses.map((excuse) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    excuse['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  _StatusChip(
                    status: excuse['status']!,
                    color: _statusColor(excuse['status']!),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'رقم الطالب: ${excuse['studentId']!}',
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 2),
              Text(
                'نوع العذر: ${excuse['type']!}',
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 2),
              Text(
                'تاريخ التقديم: ${excuse['date']!}',
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.bottomLeft,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 4,
                    ),
                  ),
                  onPressed: () {
                    context.go(AppRoutes.supervisorExcuseDetails);
                  },
                  child: const Text(
                    'عرض التفاصيل',
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
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
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
