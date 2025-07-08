import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_absence/features/auth/register/data/models/user_model.dart';

class AuthController {
  // Dependencies
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Getters
  User? get currentUser => _firebaseAuth.currentUser;
  FirebaseAuth get instance => _firebaseAuth;

  // Methods
  //* sign up with email and password
  Future<Either<AuthSuccess, AuthFail>> createUserUsingEmailAndPassword(
    UserModel userModel,
    String password,
  ) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: password,
      );
      final String userId = result.user!.uid;
      await firestore.collection('users').doc(userId).set({
        'username': userModel.name,
        'email': userModel.email,
        'role': userModel.role,
        'academicNumber': userModel.academicNumber,
      });
      return Left(AuthSuccess(userId: userId, message: 'User Created successfully'));
    } on FirebaseAuthException catch (e) {
      return Right(AuthFail(handleSignUpError(e)));
    }
  }

  //* Change Password
  Future<void> changePassword({required String newPassword}) async {
    await _firebaseAuth.currentUser!.updatePassword(newPassword);
  }

  //* Rest Forgotten Password
  Future<void> resetForgottenPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //* Sign in with email and password
  Future<Either<AuthSuccess, AuthFail>> signInWithEmailAndPassword({
    password,
    email,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Left(AuthSuccess(userId: result.user!.uid, message:'User logged in successfully'));
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return Right(AuthFail(handleLoginError(e)));
    }
  }

  //* SignOut (doesn't typically cause errord)
  Future<void> signOut() async {
    // prefrences.clearAll();
    await _firebaseAuth.signOut();
  }

  //* Reset Password
  Future<Either<ResetPasswordSuccess, ResetPasswordFailure>> resetPassword({
    email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return Left(
        ResetPasswordSuccess('Reset password email sent successfully'),
      );
    } catch (e) {
      return Right(ResetPasswordFailure(handleResetPasswordError(e)));
    }
  }

  //* Send Confirmation Mail
  Future<void> sendEmailVerification() async {
    await _firebaseAuth.currentUser!.sendEmailVerification();
  }

  //* Delete User
  Future<void> deleteUser() async {
    await _firebaseAuth.currentUser!.delete();
  }

  //? Addtional Functions

  String handleResetPasswordError(e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email address format.';

      case 'user-not-found':
        return 'No user found with this email.';

      default:
        return 'Error: ${e.message}';
    }
  }

  String handleLoginError(e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email address format.';

      case 'user-disabled':
        return 'User has been disabled.';

      case 'user-not-found':
        return 'User not found.';

      case 'wrong-password':
        return 'Incorrect password.';

      case 'too-many-requests':
        return 'Too many login attempts. Please try again later.';

      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled.';

      default:
        return 'An Error Happend While logging. Please Check your internet connection.';
    }
  }

  String handleSignUpError(e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';

      case 'invalid-email':
        return 'Invalid email address format.';

      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled.';

      case 'weak-password':
        return 'The password is too weak.';

      default:
        return 'Error: ${e.message}';
    }
  }
}

// Auth States
class AuthSuccess {
  final String userId;
  final String? message;

  AuthSuccess({required this.userId, this.message});
}

class AuthFail {
  final String message;
  AuthFail(this.message);
}

// Reset Password States

class ResetPasswordSuccess {
  final String message;

  ResetPasswordSuccess(this.message);
}

class ResetPasswordFailure {
  final String message;

  ResetPasswordFailure(this.message);
}
