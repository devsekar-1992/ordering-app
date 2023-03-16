import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GTextField extends StatelessWidget {
  String fieldLabel;
  bool isObsureText;
  ValueChanged changeFn;
  FormFieldValidator onValidate;
  TextEditingController editingController;

  // ignore: use_key_in_widget_constructors
  GTextField(
      {required this.fieldLabel,
      required this.isObsureText,
      required this.changeFn,
      required this.onValidate,
      required this.editingController});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: editingController,
        validator: onValidate,
        onChanged: changeFn,
        obscureText: isObsureText,
        decoration: InputDecoration(
          hintText: fieldLabel,
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ));
  }
}
