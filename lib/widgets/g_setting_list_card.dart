import 'package:flutter/material.dart';

class SettingListCard extends StatelessWidget {
  List<Widget> listItems = [];
  List<Widget> actionItems = [];
  SettingListCard(
      {Key? key, required this.listItems, required this.actionItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: listItems,
            ),
            Row(children: actionItems)
          ],
        ),
      ),
    );
  }
}
