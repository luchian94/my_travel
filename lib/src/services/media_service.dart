import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class MediaService {
  ImagePicker _imagePicker = ImagePicker();

  Future<Uint8List> pickImage() async {
    XFile pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85
    );

    if (pickedFile != null) {
      return pickedFile.readAsBytes();
    } else {
      return null;
    }
  }
}
