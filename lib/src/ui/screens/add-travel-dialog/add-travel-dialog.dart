import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_travel/src/models/country_model.dart';
import 'package:my_travel/src/models/travel_model.dart';
import 'package:my_travel/src/ui/screens/add-travel-dialog/add-travel-model.dart';
import 'package:my_travel/src/ui/screens/country_detail.dart';
import 'package:my_travel/src/ui/widgets/country_preview.dart';
import 'package:my_travel/src/ui/widgets/date_input.dart';
import 'package:my_travel/src/ui/widgets/flag/flag.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class AddTravelDialog extends StatelessWidget {
  final Travel travel;

  AddTravelDialog({
    Key key,
    this.travel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddTravelModel>.nonReactive(
      viewModelBuilder: () => AddTravelModel(),
      onModelReady: (model) => model.init(travel),
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text('Viaggio',
                        style: GoogleFonts.euphoriaScript(
                            textStyle: TextStyle(
                                fontSize: 30.0, color: Colors.white))),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () async {
                    Travel savedTravel = await model.saveTravel();
                    Navigator.of(context)
                        .pop({'action': 'refresh', 'data': savedTravel});
                  },
                )
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
              ),
              child: CountryDropdown(),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
              ),
              child: AddTravelDatepicker(),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0, top: 20.0),
          child: Text(
            'Sfondo',
            style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 16.0,
            ),
          ),
        ),
        CountryEditPreview()
      ],
    );
  }
}

class CountryDropdown extends ViewModelWidget<AddTravelModel> {
  const CountryDropdown({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, AddTravelModel model) {
    return DropdownSearch<Country>(
      popupProps: PopupProps.dialog(
        dialogProps: DialogProps(backgroundColor: Colors.black),
        showSelectedItems: true,
        showSearchBox: true,
        itemBuilder: _countryPopupItemBuilder,
        searchFieldProps: TextFieldProps(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(Icons.search, color: Colors.white),
              labelText: 'Cerca...',
              labelStyle: TextStyle(color: Colors.white),
              floatingLabelBehavior: FloatingLabelBehavior.never),
        ),
      ),
      items: model.countries,
      itemAsString: (Country c) => c.name,
      compareFn: (Country c, Country selectedCountry) =>
          c.name == selectedCountry.name,
      onChanged: (selectedCountry) {
        model.countryValue = selectedCountry;
      },
      // popupBackgroundColor: Colors.black,
      selectedItem: model.countryValue,
      dropdownSearchDecoration: InputDecoration(
        labelText: 'Paese',
        labelStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.only(bottom: 12.0),
      ),
      dropdownButtonProps: IconButtonProps(
        icon: Container(
          width: 60,
          child: Icon(Icons.public, color: Colors.white, size: 28.0),
        ),
      ),
      dropdownBuilder: _countryDropDown,
    );
  }

  Widget _countryDropDown(BuildContext context, Country item) {
    if (item == null) {
      return Container(
          child: Text('Seleziona il paese',
              style: TextStyle(color: Colors.white)));
    }

    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Flag(
              item.alpha,
              width: 25.0,
              height: 15.0,
            ),
          ),
          Text(
            item.name,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _countryPopupItemBuilder(
      BuildContext context, Country item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
      child: ListTile(
        selected: isSelected,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Flag(
                item.alpha,
                width: 25.0,
                height: 25.0,
              ),
            ),
            Text(
              item.name,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class AddTravelDatepicker extends HookViewModelWidget<AddTravelModel> {
  const AddTravelDatepicker({Key key}) : super(key: key);

  @override
  Widget buildViewModelWidget(BuildContext context, AddTravelModel model) {
    TextEditingController dateController = useTextEditingController();

    return DateInput(
      label: 'Data',
      readonly: true,
      controller: dateController,
      initialDate: model.selectedDate,
      onDateChange: (date) {
        model.selectedDate = date;
      },
    );
  }
}

class CountryEditPreview extends ViewModelWidget<AddTravelModel> {
  const CountryEditPreview({Key key});

  @override
  Widget build(BuildContext contextTravelModel, AddTravelModel model) {
    return CountryPreview(
      travel: Travel(
          country: model.countryValue,
          date: model.selectedDate,
          img: model.memoryPickedImage,
          position: model.imgPosition,
          previewPosition: model.previewImgPosition),
      isEdit: model.isEdit,
      onSave: () {
        model.isEdit = false;
      },
      imgMoved: (Offset position) => model.previewImgPosition = position,
      imgScaleChanged: (double scale) => model.previewImgScale = scale,
      onTapped: () {
        if (model.isEdit == false)
          showDialog(
            context: contextTravelModel,
            builder: (BuildContext context) => BuildPopupDialog(
              model: model,
              travel: Travel(
                  country: model.countryValue,
                  date: model.selectedDate,
                  img: model.memoryPickedImage,
                  scale: model.imgScale,
                  position: model.imgPosition),
            ),
          );
      },
    );
  }
}

class BuildPopupDialog extends StatelessWidget {
  final Travel travel;
  final AddTravelModel model;

  const BuildPopupDialog({
    Key key,
    this.travel,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: const EdgeInsets.all(0.0),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () async {
              Navigator.of(context).pop();
              await model.pickImage();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Text("Carica Immagine",
                      style: TextStyle(
                        color: Colors.white,
                      ))),
            ),
          ),
          MoveImage(model),
          InkWell(
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CountryDetail(
                    isEdit: true,
                    disableMenu: true,
                    onSaved: (savedData) {
                      if (savedData != null) {
                        model.imgScale = savedData['imgScale'];
                        model.imgPosition = savedData['imgPosition'];
                      }
                    },
                    travel: travel,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Sposta Immagine Dettaglio",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoveImage extends StatelessWidget {
  final AddTravelModel model;

  const MoveImage(this.model);

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        model.isEdit = true;
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 1.0,
              ),
            ),
          ),
          child: Text(
            "Sposta Immagine",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
