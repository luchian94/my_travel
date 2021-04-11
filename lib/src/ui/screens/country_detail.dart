import 'package:flutter/material.dart';
import 'package:my_travel/src/ui/models/country_model.dart';
import 'package:my_travel/src/ui/models/days_until_model.dart';
import 'package:my_travel/src/utils/utils.dart';
import 'package:photo_view/photo_view.dart';

class CountryDetail extends StatelessWidget {
  final Country country;

  CountryDetail({Key key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    DaysUntil daysUntil = country?.date != null ? getDaysUntil(country.date) : null;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 180,
          width: double.infinity,
          child: ClipRect(
            child: PhotoView(
              initialScale: PhotoViewComputedScale.covered,
              minScale: PhotoViewComputedScale.covered,
              imageProvider: country?.img != null
                  ? NetworkImage(
                  'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823__340.jpg')
                  : NetworkImage(
                  'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823__340.jpg'),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: country?.img != null ?
              DecorationImage(
                  image: country.img,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter) : null),
          child: Container(
            width: double.maxFinite,
            height: 150,
            padding: EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0, right: 5.0),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
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
                  country?.name ?? '',
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
      ],
    );
  }
}
