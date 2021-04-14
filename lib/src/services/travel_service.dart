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
      travels.add(travel);
      // TODO: find travel -> if found update -> else add
    }

    var encodedTravels = jsonEncode(travels.map((e) => e.toJson()).toList());
    return file.writeAsString(encodedTravels);
  }
}
