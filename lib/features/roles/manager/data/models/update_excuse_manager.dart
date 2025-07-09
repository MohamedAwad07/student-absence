import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerUpdateExcuseModel {
  final String? managerId;
  final String? status;
  final String? comment;
  final DateTime? updatedAt;

  ManagerUpdateExcuseModel({
    this.managerId,
    this.status,
    this.comment,
    this.updatedAt,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'managerId': managerId,
      'status': status,
      'managerComment': comment,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
