class GetExcuseInfoModel {
  final String excuseId;
  final String studentId;
  final String studentName;
  final String studentAcademicNumber;
  final String status;
  final String reason;
  String? supervisorComment;
  final String type;
  final DateTime createdAt;
  DateTime? updatedAt;
  String? fileURL;
  String? imageURL;

  GetExcuseInfoModel({
    required this.excuseId,
    required this.studentId,
    required this.studentName,
    required this.studentAcademicNumber,
    required this.status,
    required this.reason,
    this.supervisorComment,
    required this.type,
    required this.createdAt,
    this.updatedAt,
    this.fileURL,
    this.imageURL,
  });

  // factory GetExcuseInfoModel.fromFirebase(DocumentSnapshot doc) {
  //   final data = doc.data() as Map<String, dynamic>;

  //   return GetExcuseInfoModel(
  //     studentId: data['studentId'],
  //     studentName: data['studentName'],
  //     studentAcademicNumber: data['studentAcademicNumber'],
  //     status: data['status'],
  //     reason: data['reason'],
  //     type: data['type'],
  //     createdAt: (data['createdAt'] as Timestamp).toDate(),
  //     fileURL: data['fileURL'] ?? "",
  //     imageURL: data['imageURL'] ?? "",
  //   );
  // }
}
