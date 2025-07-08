// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:student_absence/core/utils/image_picker.dart';
import 'package:student_absence/core/utils/toasts.dart';
import 'package:student_absence/features/auth/controller/auth_cubit/auth_cubit.dart';
import 'package:student_absence/features/auth/controller/firebase_service.dart';

final locator = GetIt.instance;

void setUp() {
  locator.registerSingleton<AuthController>(AuthController());
  locator.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  locator.registerSingleton<ToastsHelper>(ToastsHelper());
  locator.registerSingleton<AssetsPickerHelper>(AssetsPickerHelper());
  locator.registerSingleton<AuthCubit>(AuthCubit());
}

final imagePickerLocator = locator<AssetsPickerHelper>();
final authLocator = locator<AuthController>();
final firestoreLocator = locator<FirebaseFirestore>();
final toastLocator = locator<ToastsHelper>();
final authCubitLocator = locator<AuthCubit>();
