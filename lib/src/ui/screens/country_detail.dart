import 'package:flutter/material.dart';
import 'package:my_travel/src/models/travel_model.dart';
import 'package:my_travel/src/models/days_until_model.dart';
import 'package:my_travel/src/utils/utils.dart';
import 'package:photo_view/photo_view.dart';

class CountryDetail extends StatefulWidget {
  final Travel travel;
  final bool isEdit;

  CountryDetail({Key key, this.travel, this.isEdit = false}) : super(key: key);

  @override
  _CountryDetailState createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  PhotoViewController photoViewController;
  double imgScale = 1.0;
  Offset imgPosition;

  @override
  void initState() {
    super.initState();
    photoViewController = PhotoViewController()
      ..outputStateStream.listen(listener);
    if (widget.travel != null && widget.travel.position != null) {
      photoViewController.position = widget.travel.position;
    }
  }

  @override
  void dispose() {
    photoViewController.dispose();
    super.dispose();
  }

  void listener(PhotoViewControllerValue value) {
    imgScale = value.scale;
    imgPosition = value.position;
  }

  @override
  Widget build(BuildContext context) {
    DaysUntil daysUntil =
        widget.travel?.date != null ? getDaysUntil(widget.travel.date) : null;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            child: ClipRect(
              child: PhotoView(
                controller: photoViewController,
                disableGestures: !widget.isEdit,
                initialScale: widget.travel != null
                    ? widget.travel.scale
                    : PhotoViewComputedScale.covered,
                minScale: PhotoViewComputedScale.covered,
                imageProvider: widget.travel?.img != null
                    ? widget.travel.img
                    : NetworkImage(
                        'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823__340.jpg'),
              ),
            ),
          ),
          if (widget.isEdit)
            Positioned(
              top: 10.0,
              right: 10.0,
              child: FloatingActionButton(
                child: Icon(Icons.save),
                onPressed: () {
                  var returnValue = {
                    'imgScale': imgScale,
                    'imgPosition': imgPosition
                  };
                  Navigator.of(context).pop(returnValue);
                },
              ),
            ),
          Container(
            height: 150,
            alignment: Alignment.center,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                  left: 15.0, top: 5.0, bottom: 5.0, right: 5.0),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
              child: Column(
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
                    widget.travel?.countryName ?? '',
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
      ),
    );
  }
}
