import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInput extends StatefulWidget {
  final String label;
  final String placeholder;
  final bool readonly;
  final TextEditingController controller;
  final DateTime initialDate;

  DateInput(
      {Key key,
      this.label,
      this.placeholder,
      this.readonly = false,
      this.controller,
      this.initialDate = null
      })
      : super(key: key);

  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  TextEditingController datePickerController;
  DateTime selectedDate = null;

  @override
  void initState() {
    super.initState();

    datePickerController =
        widget.controller != null ? widget.controller : TextEditingController();
    datePickerController.text = widget.initialDate != null
        ? DateFormat('dd-MM-yyyy').format(widget.initialDate)
        : DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2001),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        widget.controller.text =
            DateFormat('dd-MM-yyyy').format(picked.toLocal());
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    selectedDate = widget.initialDate != null ? widget.initialDate : DateTime.now();
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            style: TextStyle(color: Colors.grey),
            readOnly: widget.readonly,
            controller: datePickerController,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey),
              hintStyle: TextStyle(color: Colors.grey),
              labelText: widget.label,
              hintText: widget.placeholder,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          width: 60.0,
          child: MaterialButton(
            onPressed: () => _selectDate(context),
            child: Icon(Icons.calendar_today, color: Colors.white),
          ),
        )
      ],
    );
  }
}
