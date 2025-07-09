import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String?> uploadFileToCloudinary(File file, String fileType) async {
  const cloudName = 'duewbabyd';
  const uploadPreset = 'student_absence_management';

  final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/${fileType == 'pdf' ? 'raw' : 'image'}/upload');

  final request = http.MultipartRequest('POST', url)
    ..fields['upload_preset'] = uploadPreset
    ..files.add(await http.MultipartFile.fromPath('file', file.path));

  final response = await request.send();

  if (response.statusCode == 200) {
    final resData = await http.Response.fromStream(response);
    final json = jsonDecode(resData.body);
    return json['secure_url'];
  } else {
    log('Upload failed: ${response.statusCode}');
    return null;
  }
}
