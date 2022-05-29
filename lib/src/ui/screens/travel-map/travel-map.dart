import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_travel/src/ui/screens/travel-list/travel-list.dart';
import 'package:my_travel/src/ui/screens/travel-map/travel-map.model.dart';
import 'package:stacked/stacked.dart';

import 'travel-map-body.dart';

class TravelMap extends StatelessWidget {
  final String title;

  TravelMap({Key key, this.title});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TravelMapModel>.nonReactive(
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
                      style: GoogleFonts.euphoriaScript(
                          textStyle:
                              TextStyle(fontSize: 40.0, color: Colors.white))),
                ],
              )),
          body: TravelMapBody(),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.list, color: Colors.white, size: 40.0),
                    onPressed: () async {
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              TravelList(title: title),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.map, color: Colors.white, size: 40.0),
                    onPressed: null,
                  ),
                ]),
          ),
        );
      },
      viewModelBuilder: () => TravelMapModel(),
    );
  }
}
