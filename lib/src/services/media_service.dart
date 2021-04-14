import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaService {
  ImagePicker _imagePicker = ImagePicker();

  Future<File> pickImage() async {
    final pickedFile = await _imagePicker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 900,
        maxWidth: 600
    );

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }
}
