import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';

class ManagerHomePage extends StatelessWidget {
  const ManagerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> excuses = [
      {
        'status': 'معلق',
        'name': 'أحمد محمد السلام',
        'studentId': '49031052',
        'date': '22/03/2023',
        'type': 'سفر',
        'color': 'orange',
      },
      {
        'status': 'معلق',
        'name': 'سارة عنابة العمري',
        'studentId': '4382761',
        'date': '20/03/2023',
        'type': 'حالة',
        'color': 'orange',
      },
      {
        'status': 'معلق',
        'name': 'خالد عبدالرزاق الرضواني',
        'studentId': '4375652',
        'date': '18/03/2023',
        'type': 'سفر',
        'color': 'orange',
      },
      {
        'status': 'معلق',
        'name': 'نورة سعد الخطابي',
        'studentId': '4387629',
        'date': '15/03/2023',
        'type': 'أخرى',
        'color': 'orange',
      },
    ];

    Color statusTextColor(String color) {
      switch (color) {
        case 'green':
          return const Color(0xFF1E5631);
        case 'orange':
          return const Color(0xFFF9A825);
        case 'grey':
        default:
          return Colors.grey;
      }
    }

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
                  const Text(
                    'الأعذار المحولة من المشرف',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'قائمة الأعذار التي تم تحويلها إلى اتخاذ القرار النهائي',
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
                                // Status
                                Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 24,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        // color: statusColor(excuse['color']!),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        excuse['status']!,
                                        style: TextStyle(
                                          color: statusTextColor(
                                            excuse['color']!,
                                          ),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        excuse['name']!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'رقم الطالب: ${excuse['studentId']!}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        excuse['type']!,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Date
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      excuse['date']!,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
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
                                  context.go(AppRoutes.managerExcuseDetails);
                                },
                                child: const Text(
                                  'عرض التفاصيل',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                      ),
                      onPressed: () {
                        context.go(AppRoutes.managerRevisedExcuses);
                      },
                      child: const Text(
                        'عرض سجل الأعذار',
                        style: TextStyle(fontSize: 15, color: Colors.white),
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
