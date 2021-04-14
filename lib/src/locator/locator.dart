import 'package:get_it/get_it.dart';
import 'package:my_travel/src/services/media_service.dart';
import 'package:my_travel/src/services/travel_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => MediaService());
  locator.registerLazySingleton(() => TravelService());
}
