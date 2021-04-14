import 'package:my_travel/src/locator/locator.dart';
import 'package:my_travel/src/models/travel_model.dart';
import 'package:my_travel/src/services/travel_service.dart';
import 'package:stacked/stacked.dart';

class TravelListModel extends BaseViewModel {
  TravelService _travelService = locator<TravelService>();

  List<Travel> _travels = [];

  List<Travel> get travels => _travels;

  Future<void> loadTravels() async {
    _travels = await runBusyFuture(_travelService.getTravels());
    // TODO: gestire l'errore
  }
}
