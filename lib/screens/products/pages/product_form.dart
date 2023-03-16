import 'package:flutter/material.dart';

class ProductForm extends StatefulWidget {
  final int? productId;
  const ProductForm({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Products')), body: Container());
  }
}
