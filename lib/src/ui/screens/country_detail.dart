import 'package:flutter/material.dart';
import 'package:my_travel/src/locator/locator.dart';
import 'package:my_travel/src/models/travel_model.dart';
import 'package:my_travel/src/models/days_until_model.dart';
import 'package:my_travel/src/services/travel_service.dart';
import 'package:my_travel/src/utils/utils.dart';
import 'package:photo_view/photo_view.dart';

import 'add-travel-dialog/add-travel-dialog.dart';

class CountryDetail extends StatefulWidget {
  final Travel travel;
  final bool isEdit;
  final bool disableMenu;
  final bool canDelete;
  final Function onSaved;

  CountryDetail({
    Key key,
    this.travel,
    this.isEdit = false,
    this.disableMenu = false,
    this.canDelete = false,
    this.onSaved,
  }) : super(key: key);

  @override
  _CountryDetailState createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  PhotoViewController photoViewController;
  double imgScale = 1.0;
  Offset imgPosition;
  bool showMenu = false;

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
      body: InkWell(
        onTap: () => {
          if (!widget.disableMenu)
            {
              setState(() {
                showMenu = !showMenu;
              })
            }
        },
        child: Stack(
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
            Container(
              width: double.maxFinite,
              height: 150,
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                  left: 15.0, top: 5.0, bottom: 5.0, right: 5.0),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
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
            if (widget.isEdit)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton(
                    heroTag: "saveBtn",
                    child: Icon(Icons.save),
                    onPressed: () {
                      if (widget.onSaved != null) {
                        var returnValue = {
                          'imgScale': imgScale,
                          'imgPosition': imgPosition
                        };
                        widget.onSaved(returnValue);
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            if (showMenu == true)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 70.0,
                  padding: const EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(color: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute<String>(
                              builder: (BuildContext context) =>
                                  AddTravelDialog(travel: widget.travel),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                        child: Icon(Icons.edit, color: Colors.white, size: 30.0),
                      ),
                      InkWell(
                        onTap: () async {
                          await locator<TravelService>()
                              .deleteTravel(widget.travel.id);
                          Navigator.of(context).pop('refresh');
                        },
                        child: Icon(Icons.delete, color: Colors.white, size: 30.0),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
