import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/service%20locator/di.dart';
import 'package:student_absence/core/widgets/custom_text_field.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/core/utils/app_strings.dart';
import 'package:student_absence/features/auth/controller/auth_cubit/auth_cubit.dart';
import 'package:student_absence/features/auth/controller/auth_cubit/auth_state.dart';
import 'package:student_absence/features/auth/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          switch (state.user.role) {
            case 'student':
              context.go(AppRoutes.studentHome);
              break;
            case 'supervisor':
              context.go(AppRoutes.supervisorHome);
              break;
            case 'manager':
              context.go(AppRoutes.managerHome);
              break;
            default:
              context.go(AppRoutes.loginWelcome);
          }
        } else if (state is Unauthenticated) {
          toastLocator.error(context, "خطأ", state.errorMessage);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            const Text(
              AppStrings.login,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              AppStrings.loginSubtitle,
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
            const SizedBox(height: 32),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailController,
                    label: AppStrings.email,
                    prefixIcon: const Icon(
                      color: AppColors.primary,
                      Icons.email,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _passwordController,
                    label: AppStrings.password,
                    prefixIcon: const Icon(
                      color: AppColors.primary,
                      Icons.lock,
                    ),
                    suffixIcon: const Icon(
                      Icons.visibility,
                      color: AppColors.primary,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !isPasswordVisible,
                    onSuffixIconPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 32),

                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator(
                          color: AppColors.primary,
                        );
                      }
                      return CustomButton(
                        label: AppStrings.login,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              toastLocator.warning(
                                context,
                                "يجب ادخال البيانات",
                              );
                              return;
                            } else {
                              context.read<AuthCubit>().login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                            }
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 36),
                  Container(
                    width: 200,
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.containerBackground2Pink,
                    ),
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () async {
                        final emailController = TextEditingController(
                          text: _emailController.text,
                        );
                        final result = await showDialog<String>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('إعادة تعيين كلمة المرور'),
                            content: TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                labelText: 'البريد الإلكتروني',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
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
                        AppStrings.forgotPassword,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
