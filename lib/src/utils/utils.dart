import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_travel/src/ui/models/days_until_model.dart';

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

DaysUntil getDaysUntil(String date) {
  var day = date != null ? DateTime.parse(date) : null;
  var dateToday = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  var daysNumber = day.difference(dateToday).inDays;

  var daysUntil = DaysUntil(
    days: daysNumber.toString(),
    time: ''
  );

  if(daysNumber < 0){
    daysUntil.days = daysNumber.abs().toString();
    daysUntil.time = daysNumber == -1 ? ' giorno trascorso' : ' giorni trascorsi';
  }else if(daysNumber > 0){
    daysUntil.time = daysNumber == 1 ? ' giorno mancante' : ' giorni mancanti';
  }else if(daysNumber == 0){
    daysUntil.days = 'Oggi';
  }

  return daysUntil;
}
