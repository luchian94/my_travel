import 'package:flutter/material.dart';
import 'package:my_travel/src/locator/locator.dart';
import 'package:my_travel/src/services/countries_service.dart';
import 'package:my_travel/src/theme/style.dart';
import 'package:my_travel/src/ui/screens/travel-list/travel-list.dart';

void main() {
  setupLocator();

  runApp(MyApp());
  locator<CountriesService>().loadCountries();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Travel',
      theme: appTheme(),
      home: SafeArea(child: TravelList(title: 'My Travel')),
    );
  }
}

