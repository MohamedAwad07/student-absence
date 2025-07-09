import 'package:dartz/dartz.dart';
import 'package:student_absence/features/roles/student/data/repos/repo.dart';
import 'package:student_absence/features/roles/supervisor/data/models/get_excuse_info_model.dart';
import 'package:student_absence/features/roles/supervisor/data/models/update_excuse_model.dart';

abstract class SupervisorRepo {
  Future<Either<Failure, List<GetExcuseInfoModel>>> getRevisedExcuses({
    required String supervisorId,
  });
  Future<Either<Failure, List<GetExcuseInfoModel>>> getPendingExcuses();
  Future<Either<Failure, String>> updateExcuseStatus({
    required String excuseId,
    required UpdateExcuseModel updateExcuseModel,
  });
}
