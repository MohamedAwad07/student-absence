import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/routing/go_router_refresh_stream.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/core/utils/nav_bar_cubit.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/widgets/custom_profile_page.dart';
import 'package:student_absence/features/auth/login/presentation/login_screen.dart';
import 'package:student_absence/features/auth/login/presentation/login_welcome.dart';
import 'package:student_absence/features/auth/presentation/auth_gate.dart';
import 'package:student_absence/features/auth/register/presentation/register_screen.dart';
import 'package:student_absence/features/roles/manager/presentation/controller/manager_cubit/manager_cubit.dart';
import 'package:student_absence/features/roles/manager/presentation/manager_bottom_nav.dart';
import 'package:student_absence/features/roles/manager/presentation/screens/excuse_details/manager_excuse_details.dart';
import 'package:student_absence/features/roles/manager/presentation/screens/home/manager_home.dart';
import 'package:student_absence/features/roles/manager/presentation/screens/notifications/manager_notifications.dart';
import 'package:student_absence/features/roles/manager/presentation/screens/revised_excuses/manager_revised_excuses.dart';
import 'package:student_absence/features/roles/student/presentation/screens/add_excuse/student_add_excuse.dart';
import 'package:student_absence/features/roles/student/presentation/screens/home/student_home.dart';
import 'package:student_absence/features/roles/student/presentation/screens/notifications/student_notifications.dart';
import 'package:student_absence/features/roles/student/presentation/screens/track_excuses/student_track_excuses.dart';
import 'package:student_absence/features/roles/student/presentation/student_bottom_nav_bar.dart';
import 'package:student_absence/features/roles/supervisor/presentation/controller/supervisor_cubit/supervisor_cubit.dart';
import 'package:student_absence/features/roles/supervisor/presentation/screens/excuse_details/supervisor_excuse_details.dart';
import 'package:student_absence/features/roles/supervisor/presentation/screens/home/supervisor_home.dart';
import 'package:student_absence/features/roles/supervisor/presentation/screens/notifications/supervisor_notifications.dart';
import 'package:student_absence/features/roles/supervisor/presentation/screens/revised_excuses/revised_excuses.dart';
import 'package:student_absence/features/roles/supervisor/presentation/supervisor_nav_bar.dart';
import 'package:student_absence/features/splash/splash_screen.dart';
import 'package:student_absence/features/auth/controller/auth_cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_absence/features/roles/student/presentation/controller/student_cubit/student_cubit.dart';
import 'package:student_absence/features/roles/supervisor/data/models/get_excuse_info_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createAppRouter(AuthCubit authCubit) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    routes: [
      //* splash page
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const SplashView(),
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
      //* Auth Gate
      GoRoute(
        path: AppRoutes.authGate,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const AuthGate(),
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
      //* Login Welcome Page
      GoRoute(
        path: AppRoutes.loginWelcome,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const LoginWelcomeScreen(),
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
      //* login Page
      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: LoginScreen.fromGoRouterState(state),
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
      //* Register Page
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) {
          final role = state.uri.queryParameters['role'] ?? 'student';
          return CustomTransitionPage(
            key: state.pageKey,
            child: RegisterScreen(role: role),
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
      // * Student Routes
      // * Shell Route for Student
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MultiBlocProvider(
          providers: [
            BlocProvider<StudentCubit>(create: (_) => StudentCubit()),
            BlocProvider<NavBarCubit>(create: (_) => NavBarCubit()),
          ],
          child: Builder(
            builder: (context) {
              final userId = FirebaseAuth.instance.currentUser?.uid;
              if (userId == null) {
                return StudentBottomNavBar(child: child);
              }
              return StreamBuilder<int>(
                stream: context.read<StudentCubit>().getUnreadNotificationsCount(userId),
                builder: (context, snapshot) {
                  final unreadCount = snapshot.data ?? 0;
                  return StudentBottomNavBar(
                    child: child,
                    unreadNotificationsCount: unreadCount,
                  );
                },
              );
            },
          ),
        ),
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
                child: const CustomProfilePage(),
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
        builder: (context, state, child) => MultiBlocProvider(
          providers: [
            BlocProvider<SupervisorCubit>(create: (_) => SupervisorCubit()),
            BlocProvider<NavBarCubit>(create: (_) => NavBarCubit()),
          ],
          child: Builder(
            builder: (context) {
              final userId = FirebaseAuth.instance.currentUser?.uid;
              if (userId == null) {
                return SupervisorBottomNavBar(child: child);
              }
              return StreamBuilder<int>(
                stream: context.read<SupervisorCubit>().getUnreadNotificationsCount(userId),
                builder: (context, snapshot) {
                  final unreadCount = snapshot.data ?? 0;
                  return SupervisorBottomNavBar(
                    child: child,
                    unreadNotificationsCount: unreadCount,
                  );
                },
              );
            },
          ),
        ),
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
              final extra = state.extra;
              if (extra is GetExcuseInfoModel) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: SupervisorExcuseDetailsPage(excuse: extra),
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
              } else {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: Scaffold(
                    backgroundColor: AppColors.scaffoldBackground,
                    body: CustomScrollView(
                      slivers: [
                        BuildCustomAppBar(profileOnPressed: () {}),
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 8.0,
                              right: 24.0,
                              top: 16,
                              bottom: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'تفاصيل العذر',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(height: 24),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'لا توجد اعذار جديدة',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
              }
            },
          ),
          GoRoute(
            path: AppRoutes.supervisorRevisedExcuses,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const SupervisorRevisedExcusesPage(),
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
                child: const CustomProfilePage(),
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
        builder: (context, state, child) => MultiBlocProvider(
          providers: [
            BlocProvider<ManagerCubit>(create: (_) => ManagerCubit()),
            BlocProvider<NavBarCubit>(create: (_) => NavBarCubit()),
          ],
          child: Builder(
            builder: (context) {
              final userId = FirebaseAuth.instance.currentUser?.uid;
              if (userId == null) {
                return ManagerBottomNavBar(child: child);
              }
              return StreamBuilder<int>(
                stream: context.read<ManagerCubit>().getUnreadNotificationsCount(userId),
                builder: (context, snapshot) {
                  final unreadCount = snapshot.data ?? 0;
                  return ManagerBottomNavBar(
                    child: child,
                    unreadNotificationsCount: unreadCount,
                  );
                },
              );
            },
          ),
        ),
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
              final extra = state.extra;
              if (extra is GetExcuseInfoModel) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: ManagerExcuseDetails(excuse: extra),
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
              } else {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: Scaffold(
                    backgroundColor: AppColors.scaffoldBackground,
                    body: CustomScrollView(
                      slivers: [
                        BuildCustomAppBar(profileOnPressed: () {}),
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 8.0,
                              right: 24.0,
                              top: 16,
                              bottom: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'تفاصيل العذر',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(height: 24),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'لا توجد اعذار جديدة',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
              }
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
                child: const CustomProfilePage(),
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
}
