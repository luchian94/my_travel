import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_travel/src/models/travel_model.dart';
import 'package:my_travel/src/ui/widgets/country_preview.dart';

import '../country_detail.dart';

class TravelListBody extends StatelessWidget {
  final Function onAction;

  const TravelListBody({Key key, this.onAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('travels').listenable(),
      builder: (context, box, widget) {
        var travels = List<Travel>.from(box.values);
        if (travels.isEmpty) {
          return Center(
            child: Text(
              "Nessun viaggio. Clicca sul + per aggiungerne uno",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22.0),
            ),
          );
        }
        return ListView.builder(
          itemCount: travels.length,
          itemBuilder: (context, index) {
            Travel travel = travels[index];

            return CountryPreview(
              travel: travel,
              onTapped: () async {
                dynamic result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CountryDetail(
                      canDelete: true,
                      travel: travel,
                    ),
                  ),
                );
                if (result != null && this.onAction != null) {
                  this.onAction(result);
                }
              },
            );
          },
        );
      },
    );
  }
}
