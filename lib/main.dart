import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_absence/core/routing/app_router.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/core/utils/app_extension.dart';
import 'package:student_absence/core/utils/app_strings.dart';
import 'package:student_absence/bloc_observer.dart';
import 'package:student_absence/features/auth/controller/auth_cubit/auth_cubit.dart';
import 'package:student_absence/firebase_options.dart';
import 'package:flutter/services.dart';
import 'core/service locator/di.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = Observe();
  await dotenv.load(fileName: ".env");
  await FirebaseMessaging.instance.requestPermission();

  setUp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  final authCubit = AuthCubit();
  runApp(
    BlocProvider<AuthCubit>(
      create: (context) => authCubit,
      child: MyApp(authCubit: authCubit),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthCubit authCubit;
  const MyApp({super.key, required this.authCubit});

  @override
  Widget build(BuildContext context) {
    final router = createAppRouter(authCubit);
    return ScreenUtilInit(
      designSize: Size(context.width, context.height),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: ThemeData(useMaterial3: true, fontFamily: 'Cairo',
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        ),
        locale: const Locale('ar'),
        supportedLocales: [const Locale('ar')],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: router,
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },
      ),
    );
  }
}
