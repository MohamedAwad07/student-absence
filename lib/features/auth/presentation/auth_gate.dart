import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_absence/features/auth/controller/auth_cubit/auth_cubit.dart';
import 'package:student_absence/features/auth/controller/auth_cubit/auth_state.dart';
import 'package:student_absence/features/auth/login/presentation/login_welcome.dart';
import 'package:student_absence/features/roles/manager/presentation/screens/home/manager_home.dart';
import 'package:student_absence/features/roles/student/presentation/screens/home/student_home.dart';
import 'package:student_absence/features/roles/supervisor/presentation/screens/home/supervisor_home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          final userRole = state.user.role;
          if (userRole == 'student') {
            return const StudentHomePage();
          } else if (userRole == 'manager') {
            return const ManagerHomePage();
          } else if (userRole == 'supervisor') {
            return const SupervisorHomePage();
          } else {
            return const LoginWelcomeScreen();
          }
        } else {
          return const LoginWelcomeScreen();
        }
      },
    );
  }
}
