import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_travel/src/ui/screens/add-travel-dialog/add-travel-dialog.dart';
import 'package:my_travel/src/ui/screens/travel-list/travel-list-model.dart';
import 'package:stacked/stacked.dart';

import 'travel-list-body.dart';

class TravelList extends StatelessWidget {
  final String title;

  TravelList({
    Key key,
    this.title
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TravelListModel>.nonReactive(
      onModelReady: (model) => model.loadTravels(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              backgroundColor: Colors.black,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: GoogleFonts.lobster(
                          textStyle:
                          TextStyle(fontSize: 34.0, color: Colors.white))),
                ],
              )),
          body: TravelListBody(
            onAction: (String action) {
              if (action == 'refresh') {
                model.loadTravels();
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var result = await Navigator.push(
                context,
                MaterialPageRoute<String>(
                  builder: (BuildContext context) => AddTravelDialog(),
                  fullscreenDialog: true,
                ),
              );
              if (result == 'refresh') {
                model.loadTravels();
              }
            },
            elevation: 5,
            tooltip: 'Aggiungi viaggio',
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
      viewModelBuilder: () => TravelListModel(),
    );
  }
}
