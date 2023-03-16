import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ElevBtn extends StatelessWidget {
  Color? color;
  GestureTapCallback? onPressed;
  String? btnText;
  ElevBtn(
      {required this.btnText, required this.onPressed, required this.color});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
        onPressed: onPressed,
        child: Text(btnText.toString()));
  }
}
