import 'package:flutter/material.dart';
import 'package:student_absence/core/components/custom_text_field.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/core/utils/app_strings.dart';
import 'package:student_absence/features/auth/custom_button.dart';
import 'package:student_absence/features/auth/login/presentation/login_screen.dart';

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
    return Container(
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
            style: TextStyle(fontSize: 14, color: Colors.blueGrey),
          ),
          const SizedBox(height: 32),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _emailController,
                  label: AppStrings.email,
                  prefixIcon: const Icon(color: AppColors.primary, Icons.email),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _passwordController,
                  label: AppStrings.password,
                  prefixIcon: const Icon(color: AppColors.primary, Icons.lock),
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
                CustomButton(
                  label: AppStrings.login,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Center(
                              child: Text(AppStrings.fillAllFields),
                            ),
                          ),
                        );
                      } else {
                        // Navigator.pushNamed(context, '/home');
                      }
                    }
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
                    onPressed: () {},
                    child: const Text(
                      AppStrings.forgotPassword,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const RegisterPrompt(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
