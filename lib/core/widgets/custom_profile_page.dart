import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/service%20locator/di.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_absence/features/auth/controller/auth_cubit/auth_cubit.dart';
import 'package:student_absence/features/auth/controller/auth_cubit/auth_state.dart';

class CustomProfilePage extends StatefulWidget {
  const CustomProfilePage({super.key});

  @override
  State<CustomProfilePage> createState() => _CustomProfilePageState();
}

class _CustomProfilePageState extends State<CustomProfilePage> {
  bool notifyExcuses = true;
  bool notifySystem = true;

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<AuthCubit>().currentUser;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.go(AppRoutes.loginWelcome);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: CustomScrollView(
          slivers: [
            BuildCustomAppBar(profileOnPressed: () {},  fromProfile: true,),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 28,
                            backgroundColor: AppColors.primary,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userModel?.name ?? "غير معروف",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  userModel?.role == "student"
                                      ? "طالب"
                                      : userModel?.role == "supervisor"
                                      ? "مشرف"
                                      : userModel?.role == "manager"
                                      ? "مدير"
                                      : "غير معروف",
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: Colors.black45,
                          ),
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
                          onPressed: () async {
                            final emailController = TextEditingController(
                              text: userModel?.email ?? '',
                            );
                            final result = await showDialog<String>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('إعادة تعيين كلمة المرور'),
                                content: TextField(
                                  enabled: false,
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    labelText: 'البريد الإلكتروني',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('إلغاء'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.of(
                                      context,
                                    ).pop(emailController.text),
                                    child: const Text('إرسال'),
                                  ),
                                ],
                              ),
                            );
                            if (result != null && result.isNotEmpty) {
                              context.read<AuthCubit>().resetPassword(result);
                              toastLocator.success(
                                context,
                                 'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني (إن وجد).',
                              );
                            }
                          },
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
                    Row(
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          color: Colors.black45,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'البريد الإلكتروني',
                          style: TextStyle(fontSize: 14),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            userModel?.email ?? "غير معروف",
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 13,
                            ),
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
                          onChanged: null,
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
                          value: notifyExcuses,
                          onChanged: (v) {
                            setState(() {
                              notifyExcuses = v;
                            });
                          },
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
                          value: notifySystem,
                          onChanged: (v) {
                            setState(() {
                              notifySystem = v;
                            });
                          },
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
                        onPressed: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('تأكيد تسجيل الخروج'),
                              content: const Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: const Text('إلغاء'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: const Text('تأكيد', style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          );
                          if (confirmed == true) {
                            context.read<AuthCubit>().signOut();
                          }
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
