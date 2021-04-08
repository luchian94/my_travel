import 'dart:io';

import 'package:stacked/stacked.dart';

class AddTravelModel extends BaseViewModel {
  String _countryValue;
  DateTime _selectedDate = DateTime.now();
  File _pickedImage;

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
}
