import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/features/auth/controller/auth_cubit/auth_cubit.dart';
import 'package:student_absence/features/auth/controller/auth_cubit/auth_state.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/features/auth/login/presentation/login_welcome.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial || state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Unauthenticated) {
          return const LoginWelcomeScreen();
        } else if (state is Authenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final userRole = state.user.role;
            if (userRole == 'student') {
              context.go(AppRoutes.studentHome);
            } else if (userRole == 'manager') {
              context.go(AppRoutes.managerHome);
            } else if (userRole == 'supervisor') {
              context.go(AppRoutes.supervisorHome);
            } else {
              context.go(AppRoutes.loginWelcome);
            }
          });
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
