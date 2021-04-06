import 'package:flutter/material.dart';
import 'package:my_travel/src/ui/models/country_model.dart';
import 'package:my_travel/src/ui/models/days_until_model.dart';
import 'package:my_travel/src/utils/utils.dart';

class CountryDetail extends StatelessWidget {
  final Country country;

  CountryDetail({Key key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    DaysUntil daysUntil = country?.date != null ? getDaysUntil(country.date) : null;

    return Scaffold(
      body: Container(
          child: Card(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: country?.img != null ?
                  DecorationImage(
                      image: country.img.image,
                      // image: NetworkImage('https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823__340.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter) : null),
              child: Container(
                width: double.maxFinite,
                height: 150,
                padding: EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0, right: 5.0),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.6),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]),
                child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          daysUntil.days,
                          style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                            fontSize: 60.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            daysUntil.expireLabel,
                            style: new TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 15.0,
                            ),
                          ),
                        ),

                        Text(
                          country?.country ?? '',
                          style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                ),
              ),
            ),
          ))
    );
  }


}
