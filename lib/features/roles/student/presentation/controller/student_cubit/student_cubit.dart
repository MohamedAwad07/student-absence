import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_absence/core/service%20locator/di.dart';
import 'package:student_absence/features/roles/student/data/models/excuse.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(StudentInitial());

  List<StudentExcuseModel> excuses = [];
  // Submit an excuse
  Future<void> submitExcuse(StudentExcuseModel excuseModel) async {
    emit(StudentLoading());
    final result = await studentRepoLocator.submitExcuse(
      excuseModel: excuseModel,
    );
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
    result.fold((failure) => emit(StudentError(failure.message)), (excuses) {
      this.excuses = excuses;
      emit(StudentExcusesLoaded(excuses));
    });
  }

  void testSubmitExcuse() async {
    final String excuseId = DateTime.now().millisecondsSinceEpoch
        .toString(); // generates pseudo-unique ID

    final dummyExcuse = StudentExcuseModel(
      excuseId: excuseId,
      studentId: FirebaseAuth.instance.currentUser!.uid,
      reason: 'كنت مريضًا ولم أتمكن من الحضور',
      status: 'مقبولة',
      type: 'sick',
      fileURL: null,
      imageURL: null,
      supervisorId: null,
      supervisorComment: null,
      managerId: null,
      managerComment: null,
      createdAt: DateTime.now(),
      updatedAt: null,
    );

    final result = await studentRepoLocator.submitExcuse(
      excuseModel: dummyExcuse,
    );

    result.fold(
      (failure) => log('❌ Failed to submit excuse: ${failure.message}'),
      (message) => log('✅ Success: $message'),
    );
  }
}
