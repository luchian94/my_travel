import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef DateChangeCallback(DateTime date);

class DateInput extends StatefulWidget {
  final String label;
  final String placeholder;
  final bool readonly;
  final TextEditingController controller;
  final DateTime initialDate;
  final DateChangeCallback onDateChange;

  DateInput({
    Key key,
    this.label,
    this.placeholder,
    this.readonly = false,
    this.controller,
    this.onDateChange,
    this.initialDate,
  }) : super(key: key);

  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  TextEditingController datePickerController;
  DateTime selectedDate;

  _setSelectedDate() {
    selectedDate = widget.initialDate != null ? widget.initialDate : DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) => datePickerController
        .text = DateFormat('dd-MM-yyyy').format(selectedDate));
  }

  @override
  void initState() {
    super.initState();

    datePickerController = widget.controller != null ? widget.controller : TextEditingController();
    _setSelectedDate();
  }

  @override
  void didUpdateWidget(DateInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialDate != widget.initialDate) {
      _setSelectedDate();
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        widget.controller.text =
            DateFormat('dd-MM-yyyy').format(picked.toLocal());
        selectedDate = picked;
        if (widget.onDateChange != null) {
          widget.onDateChange(picked);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            readOnly: widget.readonly,
            controller: datePickerController,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white),
              labelText: widget.label,
              hintText: widget.placeholder,
              border: InputBorder.none,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Inserisci una data';
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
