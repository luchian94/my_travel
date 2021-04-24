import 'dart:convert';
import 'dart:io';

import 'package:my_travel/src/models/travel_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';

class TravelService with ReactiveServiceMixin {
  List<Travel> _travels = [];

  List<Travel> get travels => _travels;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _travelsJsonFile async {
    final path = await _localPath;
    return File('$path/travels.json');
  }

  Future<void> clearJson() async {
    final file = await _travelsJsonFile;
    file.delete();
  }

  Future<void> getTravels() async {
    try {
      final file = await _travelsJsonFile;

      String contents = await file.readAsString();
      if (contents == null || contents.isEmpty) {
        return [];
      }

      Iterable jsonTravels = jsonDecode(contents);
      _travels = List<Travel>.from(jsonTravels.map((model)=> Travel.fromJson(model)));
      notifyListeners();
    } catch (e) {
      print('ERROR LOADING TRAVELS');
    }
  }

  Future<File> saveTravel(Travel travel) async {
    final file = await _travelsJsonFile;
    if (_travels.isEmpty) {
      _travels.add(travel);
    } else {
      int travelIndex = _travels.indexWhere((t) => t.id == travel.id);
      if (travelIndex == -1) {
        _travels.add(travel);
      } else {
        _travels[travelIndex] = travel;
      }
    }

    var encodedTravels = jsonEncode(travels.map((e) => e.toJson()).toList());
    File result = await file.writeAsString(encodedTravels);
    notifyListeners();
    return result;
  }

  Future<void> deleteTravel(String travelId) async {
    final file = await _travelsJsonFile;

    _travels.removeWhere((travel) => travel.id == travelId);

    var encodedTravels = jsonEncode(travels.map((e) => e.toJson()).toList());

    await file.writeAsString(encodedTravels);
    notifyListeners();
  }
}
