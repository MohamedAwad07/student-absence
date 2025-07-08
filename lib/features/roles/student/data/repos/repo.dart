import 'package:dartz/dartz.dart';
import 'package:student_absence/features/roles/student/data/models/excuse.dart';

abstract class StudentRepo {
  Future<Either<Failure, String>> submitExcuse({required StudentExcuseModel excuseModel});
  Future<Either<Failure, String>> getExcuseStatus({required String excuseId});
  Future<Either<Failure, List<StudentExcuseModel>>> getExcuses({required String userId});
}


class StudentNotification {}

// core/errors/failure.dart
class Failure {
  final String message;
  final String? code;

  Failure(this.message, {this.code});

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}
