import 'package:flutter/material.dart';
import 'package:ordering_app/screens/categories/categories.dart';
import 'package:ordering_app/screens/home/home.dart';
import 'package:ordering_app/screens/profile/profile.dart';
import 'package:ordering_app/screens/settings/settings.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int currentState = 0;
  List<BottomNavigationBarItem> bottomNaviItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.category_outlined), label: 'Categories'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
  ];
  List<Widget> pages = [const HomeScreen(), const Category(), Settings()];
  onSelectedItem(value) {
    currentState = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(currentState),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amberAccent,
        selectedItemColor: Colors.red,
        items: bottomNaviItems,
        currentIndex: currentState,
        onTap: (value) {
          onSelectedItem(value);
        },
      ),
    );
  }
}
