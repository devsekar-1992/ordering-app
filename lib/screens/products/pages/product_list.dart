import 'package:flutter/material.dart';
import 'package:ordering_app/models/products/product_list_model.dart';
import 'package:ordering_app/screens/products/pages/product_form.dart';
import 'package:ordering_app/services/products/products.dart';
import 'package:ordering_app/widgets/g_icon_button.dart';
import 'package:ordering_app/widgets/g_setting_list_card.dart';

class ProductList extends StatefulWidget {
  ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<ProductListData> productListItems = [];
  Future<List<ProductListData>?> getProductListData() async {
    try {
      final response = await ProductRequest().getProductList();
      productListItems = response.productListData;
      setState(() {});
      return productListItems;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        title: const Text('Products'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductForm(
                        productId: null,
                      ))).then((value) => getProductListData());
        },
        child: const Icon(Icons.add, size: 25),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: productListItems.length,
                itemBuilder: (context, index) {
                  return SettingListCard(listItems: [
                    Text(
                      productListItems[index].productName.toString(),
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Chip(
                          label: Text(
                            productListItems[index].productCategory.toString(),
                            style: const TextStyle(fontSize: 12.0),
                          ),
                        ),
                        Chip(
                            label: Text(productListItems[index]
                                .productCount
                                .toString()))
                      ],
                    ),
                  ], actionItems: [
                    IButton(
                        onClick: () async {
                          final productId = productListItems[index].productId;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductForm(
                                        productId: productId,
                                      ))).then((value) => getProductListData());
                        },
                        icon: const Icon(Icons.edit)),
                    IButton(
                        onClick: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel')),
                                      ElevatedButton(
                                          onPressed: () async {
                                            final uomId =
                                                productListItems[index]
                                                    .productId;
                                            final response =
                                                await ProductRequest()
                                                    .deleteUomData(
                                                        {'uom_id': uomId});
                                            if (response.isSuccess!) {
                                              productListItems.removeWhere(
                                                  (element) =>
                                                      element.productId ==
                                                      productListItems[index]
                                                          .productId);
                                              setState(() {});
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: const Text('Sure'))
                                    ],
                                    content: const Text(
                                        'Are you sure want to delete?'));
                              });
                        },
                        icon: const Icon(Icons.delete))
                  ]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
