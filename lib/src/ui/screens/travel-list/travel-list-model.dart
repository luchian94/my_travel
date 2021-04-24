import 'package:my_travel/src/locator/locator.dart';
import 'package:my_travel/src/models/travel_model.dart';
import 'package:my_travel/src/services/travel_service.dart';
import 'package:stacked/stacked.dart';

class TravelListModel extends ReactiveViewModel {
  TravelService _travelService = locator<TravelService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_travelService];

  List<Travel> get travels => _travelService.travels;

  Future<void> loadTravels() async {
    runBusyFuture(_travelService.getTravels());
  }
}
