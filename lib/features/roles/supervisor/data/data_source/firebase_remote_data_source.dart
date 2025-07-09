import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:student_absence/core/service%20locator/di.dart';
import 'package:student_absence/features/roles/student/data/repos/repo.dart';
import 'package:student_absence/features/roles/supervisor/data/models/get_excuse_info_model.dart';
import 'package:student_absence/features/roles/supervisor/data/models/update_excuse_model.dart';
import 'package:student_absence/features/roles/supervisor/data/repos/repo.dart';

class SupervisorFirebaseRemoteDataSource implements SupervisorRepo {
  final _excusesCollection = firestoreLocator.collection('excuses');
  final _usersCollection = firestoreLocator.collection('users');

  @override
  Future<Either<Failure, List<GetExcuseInfoModel>>> getRevisedExcuses({
    required String supervisorId,
  }) async {
    try {
      // 1. Get excuses assigned to this supervisor
      final excuseQuery = await _excusesCollection
          .where('supervisorId', isEqualTo: supervisorId)
          .orderBy('createdAt', descending: true)
          .get();

      final List<GetExcuseInfoModel> result = [];

      for (final doc in excuseQuery.docs) {
        final excuseData = doc.data();
        final studentId = excuseData['studentId'];

        // 2. Get related student info
        final studentDoc = await _usersCollection.doc(studentId).get();
        final studentData = studentDoc.data();

        if (studentData != null) {
          final model = GetExcuseInfoModel(
            studentId: studentId,
            studentName: studentData['username'],
            studentAcademicNumber: studentData['academicNumber'] ?? '',
            status: excuseData['status'] ?? '',
            reason: excuseData['reason'] ?? '',
            type: excuseData['type'] ?? '',
            createdAt: (excuseData['createdAt'] as Timestamp).toDate(),
            fileURL: excuseData['fileURL'],
            imageURL: excuseData['imageURL'],
          );

          result.add(model);
        }
      }

      return Right(result);
    } catch (e) {
      return Left(
        Failure('فشل في جلب الأعذار الخاصة بالمشرف', code: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, List<GetExcuseInfoModel>>> getPendingExcuses() async {
    try {
      // 1. جلب الأعذار التي حالتها "قيد المراجعة"
      final excuseQuery = await _excusesCollection
          .where('status', isEqualTo: 'قيد المراجعة')
          .orderBy('createdAt', descending: true)
          .get();

      final List<GetExcuseInfoModel> result = [];

      for (final doc in excuseQuery.docs) {
        final excuseData = doc.data();
        final studentId = excuseData['studentId'];

        // 2. جلب بيانات الطالب من كوليكشن المستخدمين
        final studentDoc = await _usersCollection.doc(studentId).get();
        final studentData = studentDoc.data();

        if (studentData != null) {
          final model = GetExcuseInfoModel(
            studentId: studentId,
            studentName: studentData['username'] ?? '',
            studentAcademicNumber: studentData['academicNumber'] ?? '',
            status: excuseData['status'] ?? '',
            reason: excuseData['reason'] ?? '',
            type: excuseData['type'] ?? '',
            createdAt: (excuseData['createdAt'] as Timestamp).toDate(),
            fileURL: excuseData['fileURL'],
            imageURL: excuseData['imageURL'],
          );

          result.add(model);
        }
      }

      return Right(result);
    } catch (e) {
      return Left(
        Failure('فشل في جلب الأعذار قيد المراجعة', code: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, String>> updateExcuseStatus({
    required String excuseId,
    required UpdateExcuseModel updateExcuseModel,
  }) async {
    try {
      await _excusesCollection
          .doc(excuseId)
          .update(updateExcuseModel.toFirestore());

      return const Right('تم تحديث حالة العذر بنجاح');
    } catch (e) {
      return Left(Failure('فشل في تحديث حالة العذر', code: e.toString()));
    }
  }
}
