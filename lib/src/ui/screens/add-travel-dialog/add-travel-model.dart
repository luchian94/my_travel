import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:my_travel/src/locator/locator.dart';
import 'package:my_travel/src/services/media_service.dart';
import 'package:photo_view/photo_view.dart';
import 'package:stacked/stacked.dart';

class AddTravelModel extends BaseViewModel {
  MediaService _mediaService = locator<MediaService>();

  String _countryValue;
  DateTime _selectedDate = DateTime.now();
  bool _isEdit = false;
  File _pickedImage;
  PhotoViewController controller;

  AddTravelModel() {
    controller = PhotoViewController()
      ..outputStateStream.listen(listener);
  }

  String get countryValue => _countryValue;
  DateTime get selectedDate => _selectedDate;
  bool get isEdit => _isEdit;
  File get pickedImage => _pickedImage;
  MemoryImage get memoryPickedImage => _pickedImage != null ? MemoryImage(_pickedImage.readAsBytesSync()) : null;


  set countryValue(String value) {
    _countryValue = value;
    notifyListeners();
  }
  set selectedDate(DateTime value) {
    _selectedDate = value;
    notifyListeners();
  }
  set isEdit(bool value) {
    _isEdit = value;
    notifyListeners();
  }
  set pickedImage(File value) {
    _pickedImage = value;
    notifyListeners();
  }

  Future<void> pickImage() async {
    var picked = await _mediaService.pickImage();
    if (picked != null) {
      pickedImage = picked;
    }
  }

  void listener(PhotoViewControllerValue value){
    // print(value.scale);
    // print(value.position);
  }
}
