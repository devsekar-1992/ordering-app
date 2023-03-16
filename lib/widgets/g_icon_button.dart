import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IButton extends StatelessWidget {
  GestureTapCallback onClick;
  Widget icon;
  IButton({Key? key, required this.onClick, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onClick, icon: icon);
  }
}
