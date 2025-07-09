class GetExcuseInfoModel {
  final String studentId;
  final String studentName;
  final String studentAcademicNumber;
  final String status;
  final String reason;
  final String type;
  final DateTime createdAt;
  String? fileURL;
  String? imageURL;

  GetExcuseInfoModel({
    required this.studentId,
    required this.studentName,
    required this.studentAcademicNumber,
    required this.status,
    required this.reason,
    required this.type,
    required this.createdAt,
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
