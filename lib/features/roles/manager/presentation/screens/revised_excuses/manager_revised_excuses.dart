import 'package:flutter/material.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';

class ManagerRevisedExcusesPage extends StatelessWidget {
  const ManagerRevisedExcusesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> excuses = [
      {
        'status': 'مقبول',
        'title': 'عذر طبي - غياب اختبار',
        'student': 'أحمد محمد السلام',
        'desc': 'تم تقديم عذر طبي لغياب الاختبار النصفي بسبب حالة صحية طارئة',
        'date': '15 أكتوبر 2023',
      },
      {
        'status': 'مرفوض',
        'title': 'عذر طبي - غياب اختبار',
        'student': 'أحمد محمد السلام',
        'desc': 'تم تقديم عذر طبي لغياب الاختبار النصفي بسبب حالة صحية طارئة',
        'date': '15 أكتوبر 2023',
      },
      {
        'status': 'مرفوض',
        'title': 'عذر طبي - غياب اختبار',
        'student': 'أحمد محمد السلام',
        'desc': 'تم تقديم عذر طبي لغياب الاختبار النصفي بسبب حالة صحية طارئة',
        'date': '15 أكتوبر 2023',
      },
      {
        'status': 'مقبول',
        'title': 'عذر طبي - غياب اختبار',
        'student': 'أحمد محمد السلام',
        'desc': 'تم تقديم عذر طبي لغياب الاختبار النصفي بسبب حالة صحية طارئة',
        'date': '15 أكتوبر 2023',
      },
    ];
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
                  Column(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        excuse['title']!,
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        excuse['student']!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        excuse['desc']!,
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      excuse['date']!,
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
                                        excuse['status']!,
                                        style: TextStyle(
                                          color: statusTextColor(
                                            excuse['status']!,
                                          ),
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
