import 'dart:io';

import 'package:photo_view/photo_view.dart';
import 'package:stacked/stacked.dart';

class AddTravelModel extends BaseViewModel {
  String _countryValue;
  DateTime _selectedDate = DateTime.now();
  File _pickedImage;
  PhotoViewController controller;

  AddTravelModel() {
    controller = PhotoViewController()
      ..outputStateStream.listen(listener);
  }

  String get countryValue => _countryValue;
  DateTime get selectedDate => _selectedDate;
  File get pickedImage => _pickedImage;

  set selectedDate(DateTime value) {
    _selectedDate = value;
    notifyListeners();
  }
  set countryValue(String value) {
    _countryValue = value;
    notifyListeners();
  }
  set pickedImage(File value) {
    _pickedImage = value;
    notifyListeners();
  }

  void listener(PhotoViewControllerValue value){
    print(value.scale);
    print(value.position);
  }
}
