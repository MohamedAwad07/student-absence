import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_absence/core/service%20locator/di.dart';
import 'package:student_absence/features/auth/register/data/models/user_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  UserModel? currentUser;

  void checkAuthState() {
    emit(AuthLoading());
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .get();
        log("userDoc : ${userDoc.data().toString()}");
        log("user : ${firebaseUser.uid}");
        currentUser = UserModel.fromJson(userDoc.data(), firebaseUser.uid);

        emit(Authenticated(user: currentUser!));
      } else {
        emit(Unauthenticated(errorMessage: 'User is not logged in'));
      }
    });
  }

  Future<void> signUp(UserModel userModel, String password) async {
    emit(AuthLoading());
    final result = await authLocator.createUserUsingEmailAndPassword(
      userModel,
      password,
    );
    result.fold((success) async {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      currentUser = UserModel.fromJson(
        userDoc.data(),
        FirebaseAuth.instance.currentUser!.uid,
      );
      emit(Authenticated(user: currentUser!));
    }, (failure) => emit(Unauthenticated(errorMessage: failure.message)));
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await authLocator.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold((success) async {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      currentUser = UserModel.fromJson(
        userDoc.data(),
        FirebaseAuth.instance.currentUser!.uid,
      );
      emit(Authenticated(user: currentUser!));
    }, (failure) => emit(Unauthenticated(errorMessage: failure.message)));
  }

  Future<void> signOut() async {
    await authLocator.signOut();
    emit(LogoutSuccess());
  }

  Future<void> changePassword(String newPassword) async {
    emit(ChangePasswordLoading());
    try {
      await authLocator.changePassword(newPassword: newPassword);
      emit(ChangePasswordSuccess('Password changed successfully.'));
    } catch (e) {
      emit(ChangePasswordFailure(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(ResetPasswordLoading());
    final result = await authLocator.resetPassword(email: email);
    result.fold(
      (success) => emit(ResetPasswordSuccess(success.message)),
      (failure) => emit(ResetPasswordFailure(failure.message)),
    );
  }

  void reset() => emit(AuthInitial());
}
