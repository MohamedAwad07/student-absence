import 'package:equatable/equatable.dart';
import 'package:student_absence/features/auth/register/data/models/user_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthRegisterLoading extends AuthState {}

class AuthSuccessState extends AuthState {
  final String userId;
  final String message;

  AuthSuccessState(this.userId, this.message);

  @override
  List<Object?> get props => [userId, message];
}

class AuthFailureState extends AuthState {
  final String message;

  AuthFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class LogoutSuccess extends AuthState {}

class ChangePasswordLoading extends AuthState {}

class ChangePasswordSuccess extends AuthState {
  final String message;
  ChangePasswordSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class ChangePasswordFailure extends AuthState {
  final String message;
  ChangePasswordFailure(this.message);
  @override
  List<Object?> get props => [message];
}

class ResetPasswordLoading extends AuthState {}

class ResetPasswordSuccess extends AuthState {
  final String message;
  ResetPasswordSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class ResetPasswordFailure extends AuthState {
  final String message;
  ResetPasswordFailure(this.message);
  @override
  List<Object?> get props => [message];
}

class Authenticated extends AuthState {
  final UserModel user;
  Authenticated({required this.user});
  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthState {
  final String errorMessage;
  Unauthenticated({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
