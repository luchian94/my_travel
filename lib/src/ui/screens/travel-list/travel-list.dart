import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_travel/src/ui/screens/add-travel-dialog/add-travel-dialog.dart';

import '../travel-map/travel-map.dart';
import 'travel-list-body.dart';

class TravelList extends StatelessWidget {
  final String title;

  TravelList({Key key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 50.0),
              Text(title,
                  style: GoogleFonts.euphoriaScript(
                      textStyle:
                          TextStyle(fontSize: 40.0, color: Colors.white))),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AddTravelDialog(),
                      fullscreenDialog: true,
                    ),
                  );
                },
              )
            ],
          )),
      body: TravelListBody(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          IconButton(
            icon: Icon(Icons.list, color: Colors.white, size: 40.0),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.map, color: Colors.white, size: 40.0),
            onPressed: () async {
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => TravelMap(title: title,),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
