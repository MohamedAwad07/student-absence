// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:student_absence/core/utils/image_picker.dart';
import 'package:student_absence/core/utils/toasts.dart';
import 'package:student_absence/features/auth/controller/auth_cubit/auth_cubit.dart';
import 'package:student_absence/features/auth/controller/firebase_service.dart';
import 'package:student_absence/features/roles/student/data/data_source/remote_data_source.dart';
import 'package:student_absence/features/roles/student/data/repos/repo.dart';
import 'package:student_absence/features/roles/supervisor/data/data_source/firebase_remote_data_source.dart';
import 'package:student_absence/features/roles/supervisor/data/repos/repo.dart';

final locator = GetIt.instance;

void setUp() {
  locator.registerSingleton<AuthController>(AuthController());
  locator.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  locator.registerSingleton<ToastsHelper>(ToastsHelper());
  locator.registerSingleton<AssetsPickerHelper>(AssetsPickerHelper());
  locator.registerSingleton<AuthCubit>(AuthCubit());
  locator.registerLazySingleton<StudentRepo>(
    () => StudentFirebaseRemoteDataSource(),
  );
  locator.registerLazySingleton<SupervisorRepo>(
    () => SupervisorFirebaseRemoteDataSource(),
  );
}

final imagePickerLocator = locator<AssetsPickerHelper>();
final authLocator = locator<AuthController>();
final firestoreLocator = locator<FirebaseFirestore>();
final toastLocator = locator<ToastsHelper>();
final authCubitLocator = locator<AuthCubit>();
final studentRepoLocator = locator<StudentRepo>();
final supervisorRepoLocator = locator<SupervisorRepo>();
