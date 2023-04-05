import 'package:flutter/material.dart';

class GDropdown extends StatefulWidget {
  final List<DropdownMenuItem<int>> dropdownMenuItemList;
  final String dropdownLabel;
  final int selectedValue;
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
          labelStyle: const TextStyle(color: Colors.blue),
          labelText: widget.dropdownLabel),
      value: widget.selectedValue,
      isExpanded: true,
      hint: const Text('Dropdown'),
    );
  }
}
