import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/widgets/custom_text_field.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/core/utils/app_constants.dart';
import 'package:student_absence/core/utils/app_strings.dart';
import 'package:student_absence/features/auth/controller/auth_cubit/auth_cubit.dart';
import 'package:student_absence/features/auth/controller/auth_cubit/auth_state.dart';
import 'package:student_absence/features/auth/register/data/models/user_model.dart';

import '../../custom_button.dart';

class RegisterForm extends StatefulWidget {
  final String role;
  const RegisterForm({super.key, required this.role});

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

  String? selectedRole;
  final List<String> roles = ['student', 'supervisor', 'manager'];

  @override
  void initState() {
    super.initState();
    selectedRole = widget.role;

    context.read<AuthCubit>().reset();
  }

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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          switch (selectedRole) {
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
              break;
          }
        } else if (state is Unauthenticated) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          context.read<AuthCubit>().reset();
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          spacing: AppConstants.defaultSpacing,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AppStrings.register,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
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
            DropdownButtonFormField<String>(
              value: selectedRole,
              decoration: const InputDecoration(
                labelText: 'الوظيفة',
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: AppColors.primary,
                ),
              ),
              items: roles
                  .map(
                    (role) => DropdownMenuItem(
                      value: role,
                      child: Text(role[0].toUpperCase() + role.substring(1)),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedRole = value;
                });
              },
              validator: (value) =>
                  value == null ? 'يرجي اختيار الوظيفة' : null,
            ),
            const SizedBox(height: 4),
            CustomTextField(
              controller: passwordController,
              label: AppStrings.password,
              prefixIcon: const Icon(color: AppColors.primary, Icons.password),
              keyboardType: TextInputType.visiblePassword,
              obscureText: !isPasswordVisible,
              suffixIcon: const Icon(
                Icons.visibility,
                color: AppColors.primary,
              ),
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
              suffixIcon: const Icon(
                Icons.visibility,
                color: AppColors.primary,
              ),
              onSuffixIconPressed: toggleConfirmPasswordVisibility,
            ),
            const SizedBox(height: 12),

            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CircularProgressIndicator(
                    color: AppColors.primary,
                  );
                }
                return CustomButton(
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
                            content: Center(
                              child: Text(AppStrings.fillAllFields),
                            ),
                          ),
                        );
                      } else if (passwordController.text !=
                          confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Center(
                              child: Text(AppStrings.passowrdNotMatch),
                            ),
                          ),
                        );
                      } else if (selectedRole == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Center(child: Text('يرجي اختيار الوظيفة')),
                          ),
                        );
                      } else {
                        final userModel = UserModel(
                          id: '',
                          name: nameController.text,
                          email: emailController.text,
                          academicNumber: academicNumberController.text,
                          role: selectedRole!,
                        );
                        context.read<AuthCubit>().signUp(
                          userModel,
                          passwordController.text,
                        );
                      }
                    }
                  },
                );
              },
            ),
            TextButton(
              onPressed: () {
                context.go('/login/${widget.role}');
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
      ),
    );
  }
}
