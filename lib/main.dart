import 'package:flutter/material.dart';
import 'package:my_travel/src/theme/style.dart';
import 'package:my_travel/src/ui/screens/list_countries.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Travel',
      theme: appTheme(),
      home: SafeArea(child: ListCountries(title: 'My Travel')),
    );
  }
}

