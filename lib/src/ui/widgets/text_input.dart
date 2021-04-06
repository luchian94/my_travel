import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool readonly;
  final ValueChanged<String> valueChanged;
  final TextEditingController controller;

  TextInput({
    Key key,
    this.label,
    this.placeholder,
    this.readonly = false,
    this.valueChanged,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.grey),
      readOnly: readonly,
      controller: controller,
      onChanged: valueChanged,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey),
        labelText: label,
        hintText: placeholder,
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
      )
    );
  }
}
