import 'dart:ui';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GSwitcher extends StatefulWidget {
  bool isSwitched;
  ValueChanged changeEvent;
  GSwitcher({Key? key, required this.isSwitched, required this.changeEvent})
      : super(key: key);

  @override
  State<GSwitcher> createState() => _GSwitcherState();
}

class _GSwitcherState extends State<GSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: widget.isSwitched,
      onChanged: (value) {
        setState(() {
          widget.isSwitched = value;
          widget.changeEvent(value);
        });
      },
    );
  }
}
