import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_travel/src/ui/models/country_model.dart';
import 'package:my_travel/src/ui/models/days_until_model.dart';
import 'package:my_travel/src/ui/screens/add-travel-dialog/add-travel-model.dart';
import 'package:my_travel/src/utils/utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:stacked/stacked.dart';


class CountryPreview extends StatelessWidget {
  final Country country;
  final Function onTapped;

  CountryPreview({
    Key key,
    this.country,
    this.onTapped
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddTravelModel>.nonReactive(
        viewModelBuilder: () => AddTravelModel(),
        builder: (context, model, child) {
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
                      imageProvider: model.pickedImage != null
                          ? FileImage(model.pickedImage)
                          : NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823__340.jpg'),
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: 66,
                  padding: EdgeInsets.only(
                      left: 15.0, top: 5.0, bottom: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      AddTravelExpireDateLabel(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AddTravelCountryValueLabel(),
                          AddTravelDateValueLabel(),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}

class AddTravelCountryValueLabel extends ViewModelWidget<AddTravelModel> {
  const AddTravelCountryValueLabel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, AddTravelModel model) {
    return Text(
      model.countryValue ?? '',
      style: new TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontSize: 16.0,
      ),
    );
  }
}

class AddTravelDateValueLabel extends ViewModelWidget<AddTravelModel> {
  const AddTravelDateValueLabel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, AddTravelModel model) {
    String formattedDate = model.selectedDate != null
        ? DateFormat('dd MMM yyyy').format(model.selectedDate)
        : '';

    return Text(
      formattedDate,
      style: new TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w100,
        fontSize: 13.0,
      ),
    );
  }
}

class AddTravelExpireDateLabel extends ViewModelWidget<AddTravelModel> {
  const AddTravelExpireDateLabel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, AddTravelModel model) {
    DaysUntil daysUntil = getDaysUntil(model.selectedDate);

    return Row(
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
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w100,
              fontSize: 15.0,
            ),
          ),
        )
      ],
    );
  }
}
