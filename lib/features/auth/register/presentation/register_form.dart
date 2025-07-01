import 'package:flutter/material.dart';
import 'package:student_absence/core/components/custom_text_field.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/core/utils/app_constants.dart';
import 'package:student_absence/core/utils/app_strings.dart';
import 'package:student_absence/features/auth/login/presentation/login_screen.dart';

import '../../custom_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController academicNumberController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: AppConstants.defaultSpacing,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            AppStrings.register,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: nameController,
            label: AppStrings.fullName,
            prefixIcon: const Icon(color: AppColors.primary, Icons.person),
            keyboardType: TextInputType.name,
            obscureText: false,
          ),
          CustomTextField(
            controller: academicNumberController,
            label: AppStrings.academicNumber,
            prefixIcon: const Icon(
              color: AppColors.primary,
              Icons.numbers_outlined,
            ),
            keyboardType: TextInputType.name,
            obscureText: false,
          ),
          CustomTextField(
            controller: emailController,
            label: AppStrings.email,
            prefixIcon: const Icon(color: AppColors.primary, Icons.email),
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
          ),
          CustomTextField(
            controller: passwordController,
            label: AppStrings.password,
            prefixIcon: const Icon(color: AppColors.primary, Icons.password),
            keyboardType: TextInputType.visiblePassword,
            obscureText: !isPasswordVisible,
            suffixIcon: const Icon(Icons.visibility, color: AppColors.primary),
            onSuffixIconPressed: togglePasswordVisibility,
          ),
          CustomTextField(
            controller: confirmPasswordController,
            label: AppStrings.confirmPassword,
            prefixIcon: const Icon(
              color: AppColors.primary,
              Icons.password_sharp,
            ),
            keyboardType: TextInputType.visiblePassword,
            obscureText: !isConfirmPasswordVisible,
            suffixIcon: const Icon(Icons.visibility, color: AppColors.primary),
            onSuffixIconPressed: toggleConfirmPasswordVisibility,
          ),
          const SizedBox(height: 12),
          CustomButton(
            label: AppStrings.registerButton,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty ||
                    confirmPasswordController.text.isEmpty ||
                    nameController.text.isEmpty ||
                    academicNumberController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Center(child: Text(AppStrings.fillAllFields)),
                    ),
                  );
                } else if (passwordController.text !=
                    confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Center(child: Text(AppStrings.passowrdNotMatch)),
                    ),
                  );
                }
              }
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text(
              AppStrings.alreadyHaveAnAccount,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
