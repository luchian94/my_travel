import 'package:flutter/material.dart';
import 'package:my_travel/src/models/travel_model.dart';
import 'package:my_travel/src/ui/screens/travel-list/travel-list-model.dart';
import 'package:my_travel/src/ui/widgets/country_preview.dart';
import 'package:stacked/stacked.dart';

import '../country_detail.dart';

class TravelListBody extends ViewModelWidget<TravelListModel> {
  const TravelListBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, TravelListModel model) {
    if (model.isBusy) {
      return CircularProgressIndicator();
    }
    if (model.travels.isEmpty) {
      return Center(
        child: Text(
          "Nessun viaggio. Clicca sul + per aggiungerne uno",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22.0
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: model.travels.length,
      itemBuilder: (context, index) {
        Travel travel = model.travels[index];

        return CountryPreview(
          travel: travel,
          onTapped: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CountryDetail(
                  country: travel,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
