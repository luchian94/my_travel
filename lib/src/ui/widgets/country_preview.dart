import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_travel/src/models/travel_model.dart';
import 'package:my_travel/src/models/days_until_model.dart';
import 'package:my_travel/src/ui/screens/add-travel-dialog/add-travel-model.dart';
import 'package:my_travel/src/ui/widgets/flag/flag.dart';
import 'package:my_travel/src/utils/utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:stacked/stacked.dart';

typedef ImgMovedCallback(Offset position);
typedef ImgScaleChangedCallback(double scale);

class CountryPreview extends StatefulWidget {
  final Travel travel;
  final Function onTapped;
  final bool isEdit;
  final Function onSave;
  final ImgMovedCallback imgMoved;
  final ImgScaleChangedCallback imgScaleChanged;

  CountryPreview({
    Key key,
    this.travel,
    this.isEdit = false,
    this.onTapped,
    this.onSave,
    this.imgMoved,
    this.imgScaleChanged,
  }) : super(key: key);

  @override
  _CountryPreviewState createState() => _CountryPreviewState();
}

class _CountryPreviewState extends State<CountryPreview> {
  PhotoViewController controller;

  @override
  void initState() {
    super.initState();
    controller = PhotoViewController()..outputStateStream.listen(listener);
    if (widget.travel != null && widget.travel.previewPosition != null) {
      controller.position = widget.travel.previewPosition;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void listener(PhotoViewControllerValue value) {
    if (widget.imgMoved != null) {
      widget.imgMoved(value.position);
    }
    if (widget.imgScaleChanged != null) {
      widget.imgScaleChanged(value.scale);
    }
  }

  @override
  Widget build(BuildContext context) {
    DaysUntil daysUntil =
        widget.travel?.date != null ? getDaysUntil(widget.travel.date) : null;

    return InkWell(
      onTap: widget.onTapped,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if (widget.travel.img != null)
            Container(
              height: 180,
              width: double.infinity,
              child: ClipRect(
                child: PhotoView(
                  controller: controller,
                  initialScale: widget.travel != null
                      ? widget.travel.previewScale
                      : PhotoViewComputedScale.covered,
                  minScale: PhotoViewComputedScale.covered,
                  disableGestures: !widget.isEdit,
                  imageProvider: widget.travel.img,
                ),
              ),
            ),
          if (widget.isEdit)
            Positioned(
              top: 10,
              right: 10,
              child: ConfirmMove(
                onPressed: widget.onSave,
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
                    Row(
                      children: [
                        if (widget.travel?.country?.alpha != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Flag(
                              widget.travel.country?.alpha ?? '',
                              width: 20.0,
                              height: 20.0,
                            ),
                          ),
                        Text(
                          widget.travel.country?.name ?? '',
                          style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.travel?.date != null
                          ? DateFormat('dd MMM yyyy').format(widget.travel.date)
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

class ConfirmMove extends ViewModelWidget<AddTravelModel> {
  final Function onPressed;

  const ConfirmMove({Key key, this.onPressed});

  Widget build(BuildContext context, AddTravelModel model) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        icon: Icon(Icons.check),
        color: Colors.white,
        onPressed: onPressed,
      ),
    );
  }
}
