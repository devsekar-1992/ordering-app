import 'package:flutter/material.dart';
import 'package:ordering_app/screens/categories/categories_settings.dart';
import 'package:ordering_app/screens/products/products.dart';
import 'package:ordering_app/screens/uom/uom.dart';
import 'package:sliver_tools/sliver_tools.dart';

class Settings extends StatelessWidget {
  final List _settingsOptions = [
    {
      'header': 'Profile',
      'items': ['Address'],
      'screens': []
    },
    {
      'header': 'Product Settings',
      'items': ['Products', 'Uom', 'Categories'],
      'screens': <Widget>[
        const ProductsPage(),
        const UOMPage(),
        const CategorySettings()
      ]
    }
  ];
  Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        for (int i = 0; i < _settingsOptions.length; i++)
          Section(
              title: _settingsOptions[i]['header'],
              items: List.generate(
                  _settingsOptions[i]['items'].length,
                  (index) => ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return _settingsOptions[i]['screens'][index];
                          },
                        ));
                      },
                      title: Text(_settingsOptions[i]['items'][index])))),
      ],
    );
  }
}

// ignore: must_be_immutable
class Section extends MultiSliver {
  String? title;
  List<Widget> items;
  Section({super.key, required this.title, required this.items})
      : super(pushPinnedChildren: true, children: [
          SliverPinnedHeader(
              child: ColoredBox(
            color: Colors.lightBlue,
            child: ListTile(
              title: Text(title!),
            ),
          )),
          SliverList(delegate: SliverChildListDelegate.fixed(items))
        ]);
}
