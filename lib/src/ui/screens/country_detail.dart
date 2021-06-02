import 'package:flutter/material.dart';
import 'package:my_travel/src/locator/locator.dart';
import 'package:my_travel/src/models/travel_model.dart';
import 'package:my_travel/src/models/days_until_model.dart';
import 'package:my_travel/src/services/travel_service.dart';
import 'package:my_travel/src/ui/widgets/flag/flag.dart';
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
    @required this.travel,
    this.isEdit = false,
    this.disableMenu = false,
    this.canDelete = false,
    this.onSaved,
  }) : super(key: key);

  @override
  _CountryDetailState createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  Travel detailTravel;
  PhotoViewController photoViewController;
  double imgScale = 1.0;
  Offset imgPosition;
  bool showMenu = false;

  @override
  void initState() {
    super.initState();

    detailTravel = widget.travel;

    photoViewController = PhotoViewController()
      ..outputStateStream.listen(listener);
    if (detailTravel != null && detailTravel.position != null) {
      photoViewController.position = detailTravel.position;
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
        detailTravel?.date != null ? getDaysUntil(detailTravel.date) : null;

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
            if (detailTravel.img != null)
              Container(
                constraints: BoxConstraints.expand(),
                child: ClipRect(
                  child: PhotoView(
                      controller: photoViewController,
                      disableGestures: !widget.isEdit,
                      initialScale: detailTravel != null
                          ? detailTravel.scale
                          : PhotoViewComputedScale.covered,
                      minScale: PhotoViewComputedScale.covered,
                      imageProvider: detailTravel.img),
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
                  if (daysUntil.expireLabel != '')
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
                  if (detailTravel?.country?.alpha != null &&
                      detailTravel?.country?.name != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (detailTravel?.country?.alpha != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Flag(
                              detailTravel?.country?.alpha,
                              width: 25.0,
                              height: 25.0,
                            ),
                          ),
                        if (detailTravel?.country?.name != null)
                          Text(
                            detailTravel?.country?.name ?? '',
                            style: new TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 16.0,
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
            if (widget.isEdit)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: double.infinity,
                  height: 103.0,
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 16.0, right: 28.0),
                  decoration: BoxDecoration(color: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child:
                            Icon(Icons.close, color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          if (widget.onSaved != null) {
                            var returnValue = {
                              'imgScale': imgScale,
                              'imgPosition': imgPosition
                            };
                            widget.onSaved(returnValue);
                          }
                          Navigator.of(context).pop();
                        },
                        child:
                        Icon(Icons.save, color: Colors.white),
                      ),
                    ],
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
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child:
                            Icon(Icons.close, color: Colors.white, size: 30.0),
                      ),
                      InkWell(
                        onTap: () async {
                          dynamic result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AddTravelDialog(travel: detailTravel),
                              fullscreenDialog: true,
                            ),
                          );
                          if (result != null &&
                              result['action'] == 'refresh' &&
                              result['data'] != null) {
                            setState(() {
                              detailTravel = result['data'];
                            });
                          }
                        },
                        child:
                            Icon(Icons.edit, color: Colors.white, size: 30.0),
                      ),
                      InkWell(
                        onTap: () async {
                          await locator<TravelService>()
                              .deleteTravel(detailTravel.id);
                          Navigator.of(context).pop();
                        },
                        child:
                            Icon(Icons.delete, color: Colors.white, size: 30.0),
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
