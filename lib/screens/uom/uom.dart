import 'package:flutter/material.dart';
import 'package:ordering_app/screens/uom/pages/uom_list.dart';

class UOMPage extends StatefulWidget {
  const UOMPage({Key? key}) : super(key: key);

  @override
  State<UOMPage> createState() => _UOMPageState();
}

class _UOMPageState extends State<UOMPage> {
  @override
  Widget build(BuildContext context) {
    return UomLIst();
  }
}
