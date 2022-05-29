import 'package:flutter/material.dart';
import 'package:my_travel/src/locator/locator.dart';
import 'package:my_travel/src/models/country_model.dart';
import 'package:my_travel/src/models/travel_model.dart';
import 'package:my_travel/src/services/travel_service.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class TravelMapModel extends BaseViewModel {
  bool travelsLoaded = false;
  TravelService _travelService = locator<TravelService>();
  MapShapeSource _mapSource;

  MapShapeSource get mapSource => _mapSource;

  Future<void> loadTravels() async {
    List<Travel> travels = await _travelService.getTravels();
    var countries = travels.map((t) => t.country).toList();
    _setMapSource(countries);
    travelsLoaded = true;
    notifyListeners();
  }

  _setMapSource(List<Country> countries) {
    _mapSource = MapShapeSource.asset(
      'assets/geojson/map-countries.json',
      shapeDataField: "ISO_A3",
      dataCount: countries.isEmpty ? 1 : countries.length,
      primaryValueMapper: (int index) {
        return countries[index] != null
            ? countries[index].iso_3.toUpperCase()
            : '';
      },
      shapeColorValueMapper: (int index) => Colors.lightBlue,
    );
  }
}
