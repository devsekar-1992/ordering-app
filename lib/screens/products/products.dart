import 'package:flutter/material.dart';
import 'package:ordering_app/screens/products/pages/product_list.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return ProductList();
  }
}
