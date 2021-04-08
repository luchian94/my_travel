import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_travel/src/ui/models/days_until_model.dart';
import 'package:my_travel/src/ui/screens/add-travel-dialog/add-travel-model.dart';
import 'package:my_travel/src/ui/widgets/date_input.dart';
import 'package:my_travel/src/ui/widgets/text_input.dart';
import 'package:my_travel/src/utils/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddTravelModel>.nonReactive(
      viewModelBuilder: () => AddTravelModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text('Aggiungi viaggio',
                        style: GoogleFonts.lobster(
                            textStyle: TextStyle(
                                fontSize: 24.0, color: Colors.white))),
                  ),
                ),
                IconButton(icon: Icon(Icons.save), onPressed: () {})
              ],
            ),
          ),
          body: Container(
            color: Colors.black,
            padding: EdgeInsets.all(10.0),
            child: NewTravelForm(),
          ),
        );
      },
    );
  }
}

class NewTravelForm extends StatefulWidget {
  @override
  NewTravelFormState createState() {
    return NewTravelFormState();
  }
}

class NewTravelFormState extends State<NewTravelForm> {
  final _formKey = GlobalKey<FormState>();
  final countryController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
                child: CountryInput(countryController: countryController)),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
              ),
              child: AddTravelDatepicker(
                controller: dateController,
              ),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0, top: 20.0),
          child: Text(
            'Sfondo',
            style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w200,
              fontSize: 16.0,
            ),
          ),
        ),
        AddTravelImage(),
        ImageViewer()
      ],
    );
  }
}
class ImageViewer extends ViewModelWidget<AddTravelModel> {

  const ImageViewer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, AddTravelModel model) {
    return Container(
      height: 200,
      width: double.infinity,
      child: ClipRect(
        child: PhotoView(
          controller: model.controller,
          initialScale: PhotoViewComputedScale.covered,
          minScale: PhotoViewComputedScale.covered * 1.0,
          imageProvider: model.pickedImage != null ? FileImage(model.pickedImage) : NetworkImage(
              'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823__340.jpg'),
        ),
      ),
    );
  }
}


class AddTravelImage extends ViewModelWidget<AddTravelModel> {
  final picker = ImagePicker();

  AddTravelImage({
    Key key,
  }) : super(key: key);

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context, AddTravelModel model) {
    return Container(
      height: 180,
      width: double.maxFinite,
      child: Card(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
        child: InkWell(
          onTap: () async {
            File image = await getImage();
            model.pickedImage = image;
          },
          child: Container(
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              image: DecorationImage(
                  //image: img.image,
                  image: model.pickedImage != null ? FileImage(model.pickedImage) : NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823__340.jpg'),
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter),
            ),
            child: Container(
              width: double.maxFinite,
              height: 66,
              padding: EdgeInsets.only(
                  left: 15.0, top: 5.0, bottom: 5.0, right: 5.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.6),
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
            ),
          ),
        ),
      ),
    );
  }
}

class CountryInput extends ViewModelWidget<AddTravelModel> {
  final TextEditingController countryController;

  const CountryInput({Key key, this.countryController})
      : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, AddTravelModel model) {
    return TextInput(
      label: 'Paese',
      placeholder: 'Inserisci il paese...',
      controller: countryController,
      valueChanged: (text) {
        model.countryValue = text;
      },
    );
  }
}

class AddTravelDatepicker extends ViewModelWidget<AddTravelModel> {
  final TextEditingController controller;

  const AddTravelDatepicker({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context, AddTravelModel model) {
    return DateInput(
      label: 'Data',
      readonly: true,
      controller: controller,
      initialDate: model.selectedDate,
      onDateChange: (date) {
        model.selectedDate = date;
      },
    );
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
