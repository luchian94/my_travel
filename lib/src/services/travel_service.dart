import 'dart:convert';
import 'dart:io';

import 'package:my_travel/src/models/travel_model.dart';
import 'package:path_provider/path_provider.dart';

class TravelService {

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

  Future<List<Travel>> getTravels() async {
    try {
      final file = await _travelsJsonFile;

      String contents = await file.readAsString();
      if (contents == null || contents.isEmpty) {
        return [];
      }

      Iterable jsonTravels = jsonDecode(contents);
      List<Travel> travels = List<Travel>.from(jsonTravels.map((model)=> Travel.fromJson(model)));
      return travels;
    } catch (e) {
      return [];
    }
  }

  Future<File> saveTravel(Travel travel) async {
    final file = await _travelsJsonFile;
    List<Travel> travels = await getTravels();
    if (travels.isEmpty) {
      travels.add(travel);
    } else {
      int travelIndex = travels.indexWhere((t) => t.id == travel.id);
      if (travelIndex == -1) {
        travels.add(travel);
      } else {
        travels[travelIndex] = travel;
      }
    }

    var encodedTravels = jsonEncode(travels.map((e) => e.toJson()).toList());
    return file.writeAsString(encodedTravels);
  }

  Future<void> deleteTravel(String travelId) async {
    final file = await _travelsJsonFile;

    List<Travel> travels = await getTravels();
    travels.removeWhere((travel) => travel.id == travelId);

    var encodedTravels = jsonEncode(travels.map((e) => e.toJson()).toList());
    return file.writeAsString(encodedTravels);
  }
}
