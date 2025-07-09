import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_absence/core/service%20locator/di.dart';
import 'package:student_absence/features/roles/manager/data/models/update_excuse_manager.dart';
import 'package:student_absence/features/roles/student/data/repos/repo.dart';
import 'package:student_absence/features/roles/supervisor/data/models/get_excuse_info_model.dart';

part 'manager_state.dart';

class ManagerCubit extends Cubit<ManagerState> {
  ManagerCubit() : super(ManagerInitial());

  List<GetExcuseInfoModel> _pendingExcuses = [];
  List<GetExcuseInfoModel> get pendingExcuses => _pendingExcuses;

  Future<void> getRevisedExcuses(String managerId) async {
    emit(ManagerLoading());
    final result = await managerRepoLocator.getRevisedExcuses(managerId: managerId);
    result.fold(
      (failure) => emit(ManagerError(failure)),
      (excuses) => emit(ManagerRevisedExcusesLoaded(excuses)),
    );
  }

  Future<void> getPendingExcuses() async {
    emit(ManagerLoading());
    final result = await managerRepoLocator.getPendingExcuses();
    result.fold(
      (failure) => emit(ManagerError(failure)),
      (excuses) {
        _pendingExcuses = excuses;
        emit(ManagerPendingExcusesLoaded(excuses));
      },
    );
  }

  Future<void> updateExcuseStatus({
    required String excuseId,
    required ManagerUpdateExcuseModel managerUpdateExcuseModel,
  }) async {
    emit(ManagerLoading());
    final result = await managerRepoLocator.updateExcuseStatus(
      excuseId: excuseId,
      managerUpdateExcuseModel: managerUpdateExcuseModel,
    );
    result.fold(
      (failure) => emit(ManagerError(failure)),
      (message) => emit(ManagerExcuseStatusUpdated(message)),
    );
  }
}
