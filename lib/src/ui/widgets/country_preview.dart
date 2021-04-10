import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_travel/src/ui/models/country_model.dart';
import 'package:my_travel/src/ui/models/days_until_model.dart';
import 'package:my_travel/src/utils/utils.dart';
import 'package:photo_view/photo_view.dart';

class CountryPreview extends StatelessWidget {
  final Country country;
  final Function onTapped;

  CountryPreview({Key key, this.country, this.onTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DaysUntil daysUntil =
        country?.date != null ? getDaysUntil(country.date) : null;
    return InkWell(
      onTap: onTapped,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 180,
            width: double.infinity,
            child: ClipRect(
              child: PhotoView(
                initialScale: PhotoViewComputedScale.covered,
                minScale: PhotoViewComputedScale.covered,
                disableGestures: true,
                imageProvider: country?.img != null
                    ? NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823__340.jpg')
                    : NetworkImage(
                        'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823__340.jpg'),
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 66,
            padding:
                EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0, right: 5.0),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.6),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      daysUntil.days,
                      style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                        fontSize: 30.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Text(
                        daysUntil.expireLabel,
                        style: new TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontSize: 15.0,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      country.country ?? '',
                      style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      country?.date != null
                          ? DateFormat('dd MMM yyyy').format(country.date)
                          : '',
                      style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
