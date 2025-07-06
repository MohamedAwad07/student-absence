import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';

class SupervisorNotifications extends StatelessWidget {
  const SupervisorNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: CustomScrollView(
          slivers: [
            StudentHomeAppBar(profileOnPressed: () {}),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row: Section Title and Filter Icon
                    const Padding(
                      padding: EdgeInsets.only(
                        right: 16,
                        left: 8,
                        bottom: 4,
                        top: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'مركز الإشعارات',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.primary,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.filter_alt,
                            color: AppColors.secondary,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Notifications List
                    _SupervisorNotificationList(),
                    const SizedBox(height: 32),
                    Center(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 8,
                          ),
                        ),
                        onPressed: () {
                          context.go(AppRoutes.supervisorHome);
                        },
                        child: const Text(
                          'العودة للوحة التحكم',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SupervisorNotificationList extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = const [
    {
      'status': 'accepted',
      'title': 'تم قبول العذر',
      'desc': 'تم قبول عذر الطالب أحمد محمد',
      'time': 'منذ 10 دقائق',
      'icon': Icons.check,
      'color': AppColors.primary,
      'action': null,
    },
    {
      'status': 'pending',
      'title': 'عذر جديد بانتظار المراجعة',
      'desc': 'عذر جديد من الطالب سارة أحمد',
      'time': 'منذ 30 دقيقة',
      'icon': Icons.priority_high,
      'color': AppColors.secondary,
      'action': 'مراجعة',
    },
    {
      'status': 'rejected',
      'title': 'تم رفض العذر',
      'desc': 'تم رفض عذر الطالب محمد علي',
      'time': 'منذ 3 ساعات',
      'icon': Icons.percent,
      'color': Colors.red,
      'action': null,
    },
  ];

  Color _titleColor(String status) {
    switch (status) {
      case 'accepted':
        return AppColors.primary;
      case 'pending':
        return AppColors.secondary;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: notifications.map((notif) {
        return Container(
          margin: const EdgeInsets.only(top: 6, bottom: 6, right: 16),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notif['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _titleColor(notif['status']),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      notif['desc'],
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          notif['time'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    if (notif['action'] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 48,
                                vertical: 12,
                              ),
                            ),
                            onPressed: () {
                              context.go(AppRoutes.supervisorExcuseDetails);
                            },
                            child: Text(
                              notif['action'],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: notif['action'] == null ? 80 : 140,
                decoration: BoxDecoration(
                  color: notif['color'],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
