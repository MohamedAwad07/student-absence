import 'package:cloud_firestore/cloud_firestore.dart';

class StudentExcuseModel {
  String excuseId;
  String studentId;
  String reason;
  String status;
  String type;
  String? fileURL;
  String? imageURL;
  String? supervisorId;
  String? supervisorComment;
  String? managerId;
  String? managerComment;
  DateTime createdAt;
  DateTime? updatedAt;

  StudentExcuseModel({
    required this.excuseId,
    required this.studentId,
    required this.reason,
    required this.status,
    required this.type,
    this.fileURL,
    this.imageURL,
    this.supervisorId,
    this.supervisorComment,
    this.managerId,
    this.managerComment,
    required this.createdAt,
    this.updatedAt,
  });

  factory StudentExcuseModel.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return StudentExcuseModel(
      excuseId: snapshot.id,
      studentId: data['studentId'],
      reason: data['reason'],
      status: data['status'],
      type: data['type'],
      fileURL: data['fileURL'] ?? "",
      imageURL: data['imageURL'] ?? "",
      supervisorId: data['supervisorId'] ?? "",
      supervisorComment: data['supervisorComment'] ?? "",
      managerId: data['managerId'] ?? "",
      managerComment: data['managerComment'] ?? "",
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'excuseId': excuseId,
      'studentId': studentId,
      'reason': reason,
      'status': status,
      'type': type,
      'fileURL': fileURL,
      'imageURL': imageURL,
      'supervisorId': supervisorId,
      'supervisorComment': supervisorComment,
      'managerId': managerId,
      'managerComment': managerComment,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}