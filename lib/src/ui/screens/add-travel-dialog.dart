import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_travel/src/ui/models/days_until_model.dart';
import 'package:my_travel/src/ui/widgets/date_input.dart';
import 'package:my_travel/src/ui/widgets/text_input.dart';
import 'package:my_travel/src/utils/utils.dart';


class FullScreenDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Expanded(
            child: Center(
              child: Text('Aggiungi viaggio',
                  style: GoogleFonts.lobster(
                      textStyle:
                          TextStyle(fontSize: 24.0, color: Colors.white))),
            ),
          ),
          IconButton(icon: Icon(Icons.save), onPressed: () {})
        ],
      )),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(10.0),
        child: NewTravelForm(),
      ),
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
    DaysUntil daysUntil = getDaysUntil(dateController.text);

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
                child: TextInput(
                  label: 'Paese',
                  placeholder: 'Inserisci il paese...',
                  controller: countryController,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
                child: DateInput(
                  label: 'Data',
                  readonly: true,
                  controller: dateController,
                ),
              )
            ])),
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
        Container(
            height: 180,
            width: double.maxFinite,
            child: Card(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
              child: Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        //image: img.image,
                         image: NetworkImage('https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823__340.jpg'),
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter)),
                child: Container(
                  width: double.maxFinite,
                  height: 66,
                  padding: EdgeInsets.only(
                      left: 15.0, top: 5.0, bottom: 5.0, right: 5.0),
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
                              daysUntil.time,
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
                            countryController.text,
                            style: new TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            dateController.text != '' && dateController.text != null
                                ? DateFormat('dd MMM yyyy')
                                    .format(DateTime.parse(dateController.text))
                                : DateFormat('dd MMM yyyy')
                                .format(DateTime.now()),
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
              ),
            ))
      ],
    );
  }
}
