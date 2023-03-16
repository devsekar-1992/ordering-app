import 'package:flutter/material.dart';
import 'package:ordering_app/screens/categories/views/main_category_view.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MainCategory(),
    );
  }
}
