import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:student_absence/core/service%20locator/di.dart';
import 'package:student_absence/features/roles/student/data/models/excuse.dart';
import 'package:student_absence/features/roles/student/data/repos/repo.dart';

class StudentFirebaseRemoteDataSource implements StudentRepo {
  final _excusesCollection = firestoreLocator.collection('excuses');

  @override
  Future<Either<Failure, String>> submitExcuse({
    required StudentExcuseModel excuseModel,
  }) async {
    try {
      await _excusesCollection
          .doc(excuseModel.excuseId)
          .set(excuseModel.toFirestore());

      // Fetch all supervisor user IDs
      final supervisorIds = await getAllSupervisorUserIds();

      // Send notification to each supervisor
      for (final supervisorId in supervisorIds) {
        await NotificationServiceTest.sendNotification(
          userId: supervisorId,
          title: 'عذر جديد ',
          body: 'تم إضافة عذر جديد من طالب',
        );
      }

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

  // Helper method to fetch all supervisor user IDs
  Future<List<String>> getAllSupervisorUserIds() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'supervisor')
        .get();
    return querySnapshot.docs.map((doc) => doc.id).toList();
  }
}

class NotificationServiceTest {
  static Future<void> sendNotification({
    required String userId,
    required String title,
    required String body,
  }) async {
    await FirebaseFirestore.instance.collection('notifications').add({
      'userId': userId,
      'title': title,
      'body': body,
      'createdAt': FieldValue.serverTimestamp(),
      'isRead': false,
    });
  }
}
