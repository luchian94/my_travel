import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:my_travel/src/models/country_model.dart';

class CountriesService {
  List<Country> _countries = [];

  List<Country> get countries => _countries;

  Future<void> loadCountries() async {
    final String response = await rootBundle.loadString('assets/json/countries.json');
    final countriesJson = await json.decode(response);
    _countries = List<Country>.from(
        countriesJson.map((model) => Country.fromJson(model)));
  }
}
