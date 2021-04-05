import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'light_input.dart';

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

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2001),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        dateController.text = picked.toLocal().toString();
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          LightInput(
            label: 'Paese',
            placeholder: 'Inserisci il paese...',
            controller: countryController,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: LightInput(
                  label: 'Data viaggio',
                  readonly: true,
                  controller: dateController,
                ),
              ),
              SizedBox(
                width: 60.0,
                child: MaterialButton(
                  color: Colors.white,
                  onPressed: () => _selectDate(context),
                  child: Icon(Icons.calendar_today),
                ),
              ),
            ],
          )
        ]));
  }
}
