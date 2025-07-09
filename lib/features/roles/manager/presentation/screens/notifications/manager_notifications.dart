import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';

class ManagerNotificationsPage extends StatelessWidget {
  const ManagerNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'title': 'تم تحويل عذر جديد للمراجعة',
        'desc':
            'تم تحويل عذر الطالب أحمد محمد السلام إلى الفرع في مادة الرياضيات للنقاش للمراجعة. راجع الوثائق.',
        'time': 'منذ ساعتين',
      },
      {
        'title': 'تم تحويل عذر جديد للمراجعة',
        'desc':
            'تم تحويل عذر الطالب أحمد محمد السلام إلى الفرع في مادة الرياضيات للنقاش للمراجعة. راجع الوثائق.',
        'time': 'منذ ساعتين',
      },
      {
        'title': 'تم تحويل عذر جديد للمراجعة',
        'desc':
            'تم تحويل عذر الطالب أحمد محمد السلام إلى الفرع في مادة الرياضيات للنقاش للمراجعة. راجع الوثائق.',
        'time': 'منذ ساعتين',
      },
      {
        'title': 'تم تحويل عذر جديد للمراجعة',
        'desc':
            'تم تحويل عذر الطالب أحمد محمد السلام إلى الفرع في مادة الرياضيات للنقاش للمراجعة. راجع الوثائق.',
        'time': 'منذ ساعتين',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          BuildCustomAppBar(profileOnPressed: () {}),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
                      children: [
                        Text(
                          'الإشعارات',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.primary,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.filter_alt,
                          color: AppColors.primary,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: notifications.map((notif) {
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
                          spacing: 6,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Yellow dot
                                Container(
                                  width: 12,
                                  height: 12,
                                  margin: const EdgeInsetsDirectional.only(
                                    start: 4,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: AppColors.secondary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    notif['title']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              notif['desc']!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  notif['time']!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                const Spacer(),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(36, 24),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    context.go(AppRoutes.managerExcuseDetails);
                                  },
                                  child: const Text(
                                    'عرض',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
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
