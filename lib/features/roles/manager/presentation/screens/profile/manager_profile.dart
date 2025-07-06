import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';

class ManagerProfilePage extends StatelessWidget {
  const ManagerProfilePage({super.key});

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
                  vertical: 14.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    // Title
                    const Text(
                      'الإعدادات',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'خصص إعدادات حسابك وتفضيلاتك',
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                    // Profile Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: AppColors.primary,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'د. محمد السعيد',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'عضو هيئة تدريس',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right, color: Colors.black45),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Account Settings
                    const Text(
                      'إعدادات الحساب',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.lock_outline,
                          color: Colors.black45,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'كلمة المرور',
                          style: TextStyle(fontSize: 14),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'تغيير كلمة المرور',
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: Colors.black45,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'البريد الإلكتروني',
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          'm.alomari@university.edu.sa',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Language
                    const Text(
                      'اللغة',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.language,
                          color: Colors.black45,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'اللغة الحالية:',
                          style: TextStyle(fontSize: 14),
                        ),
                        const Spacer(),
                        DropdownButton<String>(
                          value: 'العربية',
                          items: const [
                            DropdownMenuItem(
                              value: 'العربية',
                              child: Text('العربية'),
                            ),
                          ],
                          onChanged: (v) {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Notifications
                    const Text(
                      'الإشعارات',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'إشعارات الاعذار الجديدة',
                          style: TextStyle(fontSize: 14),
                        ),
                        const Spacer(),
                        Switch(
                          value: true,
                          onChanged: (v) {},
                          activeColor: AppColors.primary,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'إشعارات تحديثات النظام',
                          style: TextStyle(fontSize: 14),
                        ),
                        const Spacer(),
                        Switch(
                          value: true,
                          onChanged: (v) {},
                          activeColor: AppColors.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),
                    // Logout Button
                    Center(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () {
                          context.go(AppRoutes.loginWelcome);
                        },
                        child: const Text(
                          'تسجيل الخروج',
                          style: TextStyle(fontSize: 15, color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
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
