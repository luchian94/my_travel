import 'package:flutter/material.dart';

class LightInput extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool readonly;
  final TextEditingController controller;

  LightInput({
    Key key,
    this.label,
    this.placeholder,
    this.readonly = false,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.grey),
      readOnly: readonly,
      controller: controller,
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
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
