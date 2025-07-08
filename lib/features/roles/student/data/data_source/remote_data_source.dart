import 'package:dartz/dartz.dart';
import 'package:student_absence/core/service%20locator/di.dart';
import 'package:student_absence/features/roles/student/data/models/excuse.dart';
import 'package:student_absence/features/roles/student/data/repos/repo.dart';

class FirebaseRemoteDataSource implements StudentRepo {
  final _excusesCollection = firestoreLocator.collection('excuses');

  @override
  Future<Either<Failure, String>> submitExcuse({
    required StudentExcuseModel excuseModel,
  }) async {
    try {
      await _excusesCollection
          .doc(excuseModel.excuseId)
          .set(excuseModel.toFirestore());
      return const Right('Excuse submitted successfully');
    } catch (e) {
      return Left(Failure('Failed to submit excuse', code: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getExcuseStatus({
    required String excuseId,
  }) async {
    try {
      final doc = await _excusesCollection.doc(excuseId).get();
      if (doc.exists) {
        return Right(doc.data()?['status'] ?? 'unknown');
      } else {
        return Left(Failure('Excuse not found'));
      }
    } catch (e) {
      return Left(Failure('Failed to get excuse status', code: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StudentExcuseModel>>> getExcuses({
    required String userId,
  }) async {
    try {
      final querySnapshot = await _excusesCollection
          .where('studentId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      final excuses = querySnapshot.docs
          .map((doc) => StudentExcuseModel.fromFirestore(doc))
          .toList();

      return Right(excuses);
    } catch (e) {
      return Left(Failure('Failed to get excuses', code: e.toString()));
    }
  }
}
