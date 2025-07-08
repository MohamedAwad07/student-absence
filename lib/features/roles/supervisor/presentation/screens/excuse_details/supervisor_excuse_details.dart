import 'package:flutter/material.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';

class SupervisorExcuseDetailsPage extends StatelessWidget {
  const SupervisorExcuseDetailsPage({super.key});

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
                  // Title
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: Text(
                      'تفاصيل العذر',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'يمكنك مراجعة تفاصيل العذر واتخاذ القرار للطالب',
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Excuse Info Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'معلومات الطالب',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: AppColors.primary,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Column(
                                  spacing: 4,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'أحمد محمد العطاس',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      'رقم الطالب: 4931052',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      'الشعبة: 4',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'قيد المراجعة',
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Excuse Details
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'عذر طبي',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '2023-07-01',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          'سبب العذر: بسبب المرض تم التوصية من الطبيب الاستشاري لعدم حضور أيام ورفع تقارير طبية وبعد الشفاء العودة للدراسة.',
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.attachment,
                              color: AppColors.secondary,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'تقرير طبي.pdf',
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Notes
                  const Text(
                    'إتخاذ قرار',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    minLines: 2,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'أضف ملاحظتك ...',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Decision
                  const Text(
                    'اختر القرار المناسب',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const _DecisionRadioGroup(),
                  const SizedBox(height: 18),
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'تأكيد القرار',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'رجوع',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DecisionRadioGroup extends StatefulWidget {
  const _DecisionRadioGroup();

  @override
  State<_DecisionRadioGroup> createState() => _DecisionRadioGroupState();
}

class _DecisionRadioGroupState extends State<_DecisionRadioGroup> {
  String? _decision;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<String>(
          activeColor: AppColors.primary,
          value: 'accept',
          groupValue: _decision,
          onChanged: (val) => setState(() => _decision = val),
          title: const Text('قبول العذر'),
        ),
        RadioListTile<String>(
          activeColor: AppColors.primary,
          value: 'reject',
          groupValue: _decision,
          onChanged: (val) => setState(() => _decision = val),
          title: const Text('رفض العذر'),
        ),
      ],
    );
  }
}
