import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:my_travel/src/locator/locator.dart';
import 'package:my_travel/src/services/countries_service.dart';
import 'package:my_travel/src/theme/style.dart';
import 'package:my_travel/src/ui/screens/travel-list/travel-list.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setupLocator();

  runApp(MyApp());
  await locator<CountriesService>().loadCountries();
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Travel',
      theme: appTheme(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('it', ''),
      ],
      home: Container(
          color: Colors.orange,
          child: SafeArea(child: TravelList(title: 'My Travel'))),
    );
  }
}
