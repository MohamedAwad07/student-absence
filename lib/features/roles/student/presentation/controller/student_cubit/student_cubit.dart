import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_absence/core/service%20locator/di.dart';
import 'package:student_absence/features/roles/student/data/models/excuse.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(StudentInitial());

  // Submit an excuse
  Future<void> submitExcuse(StudentExcuseModel excuseModel) async {
    emit(StudentLoading());
    final result = await studentRepoLocator.submitExcuse(excuseModel: excuseModel);
    result.fold(
      (failure) => emit(StudentError(failure.message)),
      (message) => emit(StudentExcuseSubmitted(message)),
    );
  }

  // Get status of a specific excuse
  Future<void> getExcuseStatus(String excuseId) async {
    emit(StudentLoading());
    final result = await studentRepoLocator.getExcuseStatus(excuseId: excuseId);
    result.fold(
      (failure) => emit(StudentError(failure.message)),
      (status) => emit(StudentExcuseStatusLoaded(status)),
    );
  }

  // Get all excuses for a student
  Future<void> getExcuses(String userId) async {
    emit(StudentLoading());
    final result = await studentRepoLocator.getExcuses(userId: userId);
    result.fold(
      (failure) => emit(StudentError(failure.message)),
      (excuses) => emit(StudentExcusesLoaded(excuses)),
    );
  }
}
