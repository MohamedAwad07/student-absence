part of 'student_cubit.dart';

sealed class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object?> get props => [];
}

final class StudentInitial extends StudentState {}
final class StudentLoading extends StudentState {}
final class StudentError extends StudentState {
  final String message;
  const StudentError(this.message);
  @override
  List<Object?> get props => [message];
}
final class StudentExcuseSubmitted extends StudentState {
  final String message;
  const StudentExcuseSubmitted(this.message);
  @override
  List<Object?> get props => [message];
}
final class StudentExcuseStatusLoaded extends StudentState {
  final String status;
  const StudentExcuseStatusLoaded(this.status);
  @override
  List<Object?> get props => [status];
}
final class StudentExcusesLoaded extends StudentState {
  final List<StudentExcuseModel> excuses;
  const StudentExcusesLoaded(this.excuses);
  @override
  List<Object?> get props => [excuses];
}
