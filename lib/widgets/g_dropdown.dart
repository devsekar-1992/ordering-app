import 'package:flutter/material.dart';

class GDropdown extends StatefulWidget {
  final List<DropdownMenuItem<int>> dropdownMenuItemList;
  final String dropdownLabel;
  final int? selectedValue;
  final void Function(dynamic) onChanged;
  const GDropdown(
      {Key? key,
      required this.dropdownMenuItemList,
      required this.onChanged,
      required this.selectedValue,
      required this.dropdownLabel})
      : super(key: key);

  @override
  State<GDropdown> createState() => _GDropdownState();
}

class _GDropdownState extends State<GDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: widget.dropdownMenuItemList,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.black, width: 1)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1)),
          labelStyle: const TextStyle(color: Colors.blue),
          labelText: widget.dropdownLabel),
      value: widget.selectedValue,
      isExpanded: true,
      hint: const Text('Dropdown'),
    );
  }
}
