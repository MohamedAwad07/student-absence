class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? role;
  final String? academicNumber;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.academicNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json, String uid) {
    return UserModel(
      id: uid,
      name: json!['username'],
      email: json['email'],
      role: json['role'],
      academicNumber: json['academicNumber'],
    );
  }
}
