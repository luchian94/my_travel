import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:my_travel/src/locator/locator.dart';
import 'package:my_travel/src/models/country_model.dart';
import 'package:my_travel/src/models/travel_model.dart';
import 'package:my_travel/src/services/countries_service.dart';
import 'package:my_travel/src/services/media_service.dart';
import 'package:my_travel/src/services/travel_service.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

class AddTravelModel extends BaseViewModel {
  MediaService _mediaService = locator<MediaService>();
  TravelService _travelService = locator<TravelService>();
  CountriesService _countriesService = locator<CountriesService>();

  String _travelId;
  Country _countryValue;
  DateTime _selectedDate = DateTime.now();
  bool _isEdit = false;
  MemoryImage _memoryPickedImage;

  double imgScale = 0.0;
  Offset imgPosition = Offset(0, 0);

  double previewImgScale = 0.0;
  Offset previewImgPosition = Offset(0, 0);

  Country get countryValue => _countryValue;
  DateTime get selectedDate => _selectedDate;
  bool get isEdit => _isEdit;
  MemoryImage get memoryPickedImage => _memoryPickedImage;

  List<Country> get countries => _countriesService.countries;

  set countryValue(Country value) {
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

  Future<void> init(Travel travel) async {
    await setTravelData(travel);
    notifyListeners();
  }

  Future<void> setTravelData(Travel travel) async {
    if (travel != null) {
      _travelId = travel.id;
      _countryValue = travel.country;
      _selectedDate = travel.date;
      imgScale = travel.scale;
      imgPosition = travel.position;
      previewImgScale = travel.previewScale;
      previewImgPosition = travel.previewPosition;
      _memoryPickedImage = travel.img;
    } else {
      var uuid = Uuid();
      _travelId = uuid.v1();
      _memoryPickedImage = await getPlaceholderImage();
    }
  }

  Future<MemoryImage> getPlaceholderImage() async {
    Uint8List placeholderBytes = (await rootBundle.load('assets/images/placeholder.jpg'))
        .buffer
        .asUint8List();
    return MemoryImage(placeholderBytes);
  }

  Future<void> pickImage() async {
    var pickedImageBytes = await _mediaService.pickImage();
    if (pickedImageBytes != null) {
      _memoryPickedImage = MemoryImage(pickedImageBytes);
      notifyListeners();
    }
  }

  Future<Travel> saveTravel() async {
    // await _travelService.clearJson(); // per svuotare il json
    Travel travel = new Travel(
      id: _travelId,
      country: countryValue,
      img: memoryPickedImage,
      date: selectedDate,
      scale: imgScale,
      position: imgPosition,
      previewScale: previewImgScale,
      previewPosition: previewImgPosition,
    );
    await _travelService.saveTravel(travel);
    return travel;
  }
}
