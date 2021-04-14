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
    return ListView.builder(
      itemCount: model.travels.length,
      itemBuilder: (context, index) {
        Travel travel = model.travels[index];

        return CountryPreview(
          country: travel,
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
