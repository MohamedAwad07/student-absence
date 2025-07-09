import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateExcuseModel {
  final String? supervisorId;
  final String? status;
  final String? comment;
  final DateTime? updatedAt;

  UpdateExcuseModel({
    this.supervisorId,
    this.status,
    this.comment,
    this.updatedAt,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'supervisorId': supervisorId,
      'status': status,
      'supervisorComment': comment,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
