import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_travel/src/models/travel_model.dart';
import 'package:stacked/stacked.dart';

class TravelService with ReactiveServiceMixin {
  final _travelsBox = Hive.box('travels');

  List<Travel> _travels = [];

  List<Travel> get travels => _travels;

  Future<List<Travel>> getTravels() async {
    return List<Travel>.from(_travelsBox.values);
  }

  Future<void> saveTravel(Travel travel) async {
    _travelsBox.put(travel.id, travel);
  }

  Future<void> deleteTravel(String travelId) async {
    _travelsBox.delete(travelId);
  }
}
