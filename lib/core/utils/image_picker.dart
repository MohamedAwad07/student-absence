import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_absence/core/services/cloudinary.dart';

class AssetsPickerHelper {
  Future<String?> pickImageFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final file = File(picked.path);
      final url = await uploadFileToCloudinary(file, 'image');
      if (url != null) {
        return url;
      } else {
        log('Upload failed: $url');
        return null;
      }
    }
    return null;
  }

  Future<String?> pickPdfFromGallery() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      final file = File(result.files.single.path!);
      final url = await uploadFileToCloudinary(file, 'pdf');
      if (url != null) {
        return url;
      } else {
        log('Upload failed: $url');
        return null;
      }
    }
    return null;
  }
}
