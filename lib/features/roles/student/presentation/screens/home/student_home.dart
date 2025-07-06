import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/core/widgets/app_bar.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

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
                children: [
                  // Profile Section
                  const Column(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: Color(0xFFD4A63A),
                        child: Icon(
                          Icons.person,
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'أحمد محمد مهدي',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'رقم الطالب: 445521',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Summary Cards
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _SummaryCard(
                        count: 3,
                        label: 'مقبولة',
                        color: Color(0xFF4CAF50),
                      ),
                      _SummaryCard(
                        count: 1,
                        label: 'قيد المراجعة',
                        color: Color(0xFFFFC107),
                      ),
                      _SummaryCard(
                        count: 2,
                        label: 'مرفوضة',
                        color: Color(0xFFF44336),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Latest Excuses
                  _SectionTitle(title: 'ملخص الأعذار', onPressed: () {}),
                  const SizedBox(height: 8),
                  _ExcuseList(),
                  const SizedBox(height: 18),
                  // Notifications
                  _SectionTitle(title: 'الإشعارات', onPressed: () {}),
                  const SizedBox(height: 8),
                  _NotificationList(),
                  const SizedBox(height: 24),
                  // Settings Button
                  Center(
                    child: TextButton.icon(
                      onPressed: () => context.go(AppRoutes.studentProfilePage),
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
          color: color.withOpacity(0.12),
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

class _ExcuseList extends StatelessWidget {
  final List<Map<String, String>> excuses = const [
    {'title': 'عذر طبي', 'status': 'مقبولة', 'date': '2023-04-15'},
    {
      'title': 'عذر غياب - محاضرة برمجة',
      'status': 'قيد المراجعة',
      'date': '2023-04-10',
    },
    {
      'title': 'عذر غياب - محاضرة شبكات',
      'status': 'مرفوضة',
      'date': '2023-04-05',
    },
  ];

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: excuses.map((excuse) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: Icon(
              Icons.description,
              color: _statusColor(excuse['status']!),
            ),
            title: Text(
              excuse['title']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('تاريخ التقديم: ${excuse['date']}'),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _statusColor(excuse['status']!).withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                excuse['status']!,
                style: TextStyle(
                  color: _statusColor(excuse['status']!),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
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
