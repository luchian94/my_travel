import 'package:stacked/stacked.dart';

class AddTravelModel extends BaseViewModel {
  String _countryValue;
  DateTime _selectedDate = DateTime.now();

  String get countryValue => _countryValue;
  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime value) {
    _selectedDate = value;
    notifyListeners();
  }
  set countryValue(String value) {
    _countryValue = value;
    notifyListeners();
  }
}
