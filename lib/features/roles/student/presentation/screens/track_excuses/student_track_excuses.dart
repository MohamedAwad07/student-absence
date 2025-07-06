import 'package:flutter/material.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';

class StudentTrackExcuses extends StatelessWidget {
  const StudentTrackExcuses({super.key});

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
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'متابعة الأعذار',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'يمكنك متابعة حالة الأعذار الخاصة بك',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                    // Excuses List
                    _ExcuseTrackList(),
                    const SizedBox(height: 32),
                    // Submit New Excuse Button
                    Center(
                      child: SizedBox(
                        width: 220,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'تقديم عذر جديد',
                            style: TextStyle(fontSize: 15, color: Colors.white),
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

class _ExcuseTrackList extends StatelessWidget {
  final List<Map<String, String>> excuses = const [
    {'title': 'عذر طبي', 'status': 'قيد المراجعة', 'date': '2023-04-15'},
    {'title': 'عذر سفر', 'status': 'مقبول', 'date': '2023-04-12'},
    {'title': 'عذر طبي', 'status': 'مرفوض', 'date': '2023-04-10'},
    {'title': 'عذر سفر', 'status': 'مقبول', 'date': '2023-04-08'},
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'قيد المراجعة':
        return const Color(0xFFFFC107);
      case 'مقبول':
        return const Color(0xFF4CAF50);
      case 'مرفوض':
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: excuses.map((excuse) {
          return Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 0,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          excuse['title']!,
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
                    const SizedBox(height: 8),
                  ],
                ),
                subtitle: Text(
                  'تاريخ التقديم: ${excuse['date']}',
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
              const Divider(height: 1, thickness: 0.5, indent: 8, endIndent: 8),
            ],
          );
        }).toList(),
      ),
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
