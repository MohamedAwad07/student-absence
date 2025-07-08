import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/features/auth/login/presentation/login_screen.dart';
import 'package:student_absence/features/auth/login/presentation/login_welcome.dart';
import 'package:student_absence/features/auth/presentation/auth_gate.dart';
import 'package:student_absence/features/auth/register/presentation/register_screen.dart';
import 'package:student_absence/features/roles/manager/presentation/manager_bottom_nav.dart';
import 'package:student_absence/features/roles/manager/presentation/screens/excuse_details/manager_excuse_details.dart';
import 'package:student_absence/features/roles/manager/presentation/screens/home/manager_home.dart';
import 'package:student_absence/features/roles/manager/presentation/screens/notifications/manager_notifications.dart';
import 'package:student_absence/features/roles/manager/presentation/screens/profile/manager_profile.dart';
import 'package:student_absence/features/roles/manager/presentation/screens/revised_excuses/manager_revised_excuses.dart';
import 'package:student_absence/features/roles/student/presentation/screens/add_excuse/student_add_excuse.dart';
import 'package:student_absence/features/roles/student/presentation/screens/home/student_home.dart';
import 'package:student_absence/features/roles/student/presentation/screens/notifications/student_notifications.dart';
import 'package:student_absence/features/roles/student/presentation/screens/profile/student_profile.dart';
import 'package:student_absence/features/roles/student/presentation/screens/track_excuses/student_track_excuses.dart';
import 'package:student_absence/features/roles/student/presentation/student_bottom_nav_bar.dart';
import 'package:student_absence/features/roles/supervisor/presentation/screens/excuse_details/supervisor_excuse_details.dart';
import 'package:student_absence/features/roles/supervisor/presentation/screens/home/supervisor_home.dart';
import 'package:student_absence/features/roles/supervisor/presentation/screens/notifications/supervisor_notifications.dart';
import 'package:student_absence/features/roles/supervisor/presentation/screens/profile/supervisor_profile.dart';
import 'package:student_absence/features/roles/supervisor/presentation/supervisor_nav_bar.dart';
import 'package:student_absence/features/splash/splash_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  routes: [
    //* splash page
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const SplashView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInQuad).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    //* Auth Gate
    GoRoute(
      path: AppRoutes.authGate,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const AuthGate(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInQuad).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    //* Login Welcome Page
    GoRoute(
      path: AppRoutes.loginWelcome,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const LoginWelcomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInQuad).animate(animation),
              child: child,
            );
          },
        );
      },
    ),

    //* login Page
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: LoginScreen.fromGoRouterState(state),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInQuad).animate(animation),
              child: child,
            );
          },
        );
      },
    ),

    //* Register Page
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) {
        final role = state.uri.queryParameters['role'] ?? 'student';
        return CustomTransitionPage(
          key: state.pageKey,
          child: RegisterScreen(role: role),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInQuad).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    // * Student Routes
    // * Shell Route for Student
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => StudentBottomNavBar(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.studentHome,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const StudentHomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInQuad,
                      ).animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.studentTrackExcuses,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const StudentTrackExcuses(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInQuad,
                      ).animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.studentAddExcuses,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const StudentAddExcusePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInQuad,
                      ).animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.studentNotifications,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const StudentNotifications(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInQuad,
                      ).animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.studentProfilePage,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const StudentProfilePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInQuad,
                      ).animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
      ],
    ),

    // * Supervisor Routes
    // * Shell Route for Supervisor
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => SupervisorBottomNavBar(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.supervisorHome,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const SupervisorHomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInQuad,
                      ).animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.supervisorExcuseDetails,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const SupervisorExcuseDetailsPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInQuad,
                      ).animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.supervisorNotifications,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const SupervisorNotifications(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInQuad,
                      ).animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.supervisorProfilePage,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const SupervisorProfilePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInQuad,
                      ).animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
      ],
    ),

    // * Manager Routes
    // * Shell Route for Manager
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ManagerBottomNavBar(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.managerHome,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const ManagerHomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInQuad,
                      ).animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.managerRevisedExcuses,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const ManagerRevisedExcusesPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInQuad,
                      ).animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.managerExcuseDetails,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const ManagerExcuseDetails(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInQuad,
                      ).animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.managerNotifications,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const ManagerNotificationsPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInQuad,
                      ).animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
        GoRoute(
          path: AppRoutes.managerProfilePage,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const ManagerProfilePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInQuad,
                      ).animate(animation),
                      child: child,
                    );
                  },
            );
          },
        ),
      ],
    ),
  ],
);
