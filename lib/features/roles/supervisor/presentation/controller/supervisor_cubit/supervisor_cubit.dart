import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_absence/core/service%20locator/di.dart';
import 'package:student_absence/features/roles/student/data/repos/repo.dart';
import 'package:student_absence/features/roles/supervisor/data/models/get_excuse_info_model.dart';
import 'package:student_absence/features/roles/supervisor/data/models/update_excuse_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Stream<int> getUnreadNotificationsCount(String userId) {
    return FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Future<void> markAllNotificationsAsRead(String userId) async {
    final batch = FirebaseFirestore.instance.batch();
    final query = await FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .get();
    for (var doc in query.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }
}
