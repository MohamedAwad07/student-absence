import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_absence/core/service%20locator/di.dart';
import 'package:student_absence/features/roles/student/data/repos/repo.dart';
import 'package:student_absence/features/roles/supervisor/data/models/get_excuse_info_model.dart';
import 'package:student_absence/features/roles/supervisor/data/models/update_excuse_model.dart';

part 'supervisor_state.dart';

class SupervisorCubit extends Cubit<SupervisorState> {
  SupervisorCubit() : super(SupervisorInitial());

  Future<void> getRevisedExcuses(String supervisorId) async {
    emit(SupervisorLoading());
    final result = await supervisorRepoLocator.getRevisedExcuses(supervisorId: supervisorId);
    result.fold(
      (failure) => emit(SupervisorError(failure)),
      (excuses) => emit(SupervisorRevisedExcusesLoaded(excuses)),
    );
  }

  Future<void> getPendingExcuses() async {
    emit(SupervisorLoading());
    final result = await supervisorRepoLocator.getPendingExcuses();
    result.fold(
      (failure) => emit(SupervisorError(failure)),
      (excuses) => emit(SupervisorPendingExcusesLoaded(excuses)),
    );
  }

  Future<void> updateExcuseStatus({
    required String excuseId,
    required UpdateExcuseModel updateExcuseModel,
  }) async {
    emit(SupervisorLoading());
    final result = await supervisorRepoLocator.updateExcuseStatus(
      excuseId: excuseId,
      updateExcuseModel: updateExcuseModel,
    );
    result.fold(
      (failure) => emit(SupervisorError(failure)),
      (message) => emit(SupervisorExcuseStatusUpdated(message)),
    );
  }
}
