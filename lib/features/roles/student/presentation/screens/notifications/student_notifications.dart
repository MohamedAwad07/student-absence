import 'package:flutter/material.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';

class StudentNotifications extends StatelessWidget {
  const StudentNotifications({super.key});

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Filter and Title Row
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Text(
                            'مركز الإشعارات',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
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
                    _NotificationList(),
                    const SizedBox(height: 24),
                    // Show More Button
                    Center(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'عرض المزيد',
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

class _NotificationList extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = const [
    {
      'status': 'accepted',
      'title': 'تم قبول العذر',
      'desc': 'تم قبول عذر غياب بتاريخ 15 صفر 1445',
      'user': 'م. محمد نصيري',
      'date': 'منذ ساعتين',
      'action': 'عرض التفاصيل',
    },
    {
      'status': 'rejected',
      'title': 'تم رفض العذر',
      'desc': 'تم رفض عذر غياب بسبب عدم كفاية الأدلة المقدمة',
      'user': 'م. لؤي مسلم',
      'date': 'أمس 20:15',
      'action': 'عرض التفاصيل',
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'accepted':
        return AppColors.secondary;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: notifications.map((notif) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notif['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: notif['status'] == 'rejected'
                              ? Colors.red
                              : AppColors.primary,
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
                          Text(
                            notif['user'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            notif['date'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            notif['action'],
                            style: TextStyle(
                              color: notif['status'] == 'rejected'
                                  ? Colors.red
                                  : AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Status Bar
              Container(
                width: 6,
                height: 100,
                decoration: BoxDecoration(
                  color: _statusColor(notif['status']),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
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
