import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ordering_app/models/picklist/picklist_model.dart';
import 'package:ordering_app/models/products/products_edit_form_model.dart';
import 'package:ordering_app/services/category/main_category.dart';
import 'package:ordering_app/services/generic/generic.dart';
import 'package:ordering_app/services/products/products.dart';
import 'package:ordering_app/widgets/g_button.dart';
import 'package:ordering_app/widgets/g_dropdown.dart';
import 'package:ordering_app/widgets/g_icon_button.dart';
import 'package:ordering_app/widgets/g_setting_list_card.dart';
import 'package:ordering_app/widgets/g_snack_bar.dart';
import 'package:ordering_app/widgets/g_text.dart';

class ProductForm extends StatefulWidget {
  final int? productId;
  const ProductForm({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  List<ProductEditFormData> _addSubCategory = [];
  List<SubCategory> _subCategoryItems = [];
  List<Brand> _brandItems = [];
  final _mainProductField = TextEditingController();
  final _subCategoryField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _mainFormKey = GlobalKey<FormState>();
  int? mainProductId;
  String? responseMessage = '';
  bool? isSuccess = false;
  String _currentIndex = '';

  //Load Form Data
  void showFormInfo() async {
    try {
      if (widget.productId != null) {
        final response =
            await ProductRequest().getProductsById(widget.productId);
        mainProductId = response.mainProductId;
        _mainProductField.text = response.mainProductName!;
        _addSubCategory = response.productEditData;
        setState(() {});
      }
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  /// Load Picklist Data
  void loadPicklistData() async {
    try {
      final response = await GenericRequest().getPicklistData();
      isSuccess = response.isSuccess;
      responseMessage = response.msg;
      _brandItems = response.brandItems;
      _subCategoryItems = response.subCategoryItems;
      setState(() {});
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  //Load Subcategory in dropdownitems
  List<DropdownMenuItem<int>> _buildSubCategory() {
    List<DropdownMenuItem<int>> items = List.empty(growable: true);
    for (var i = 0; i < _subCategoryItems.length; i++) {
      items.add(DropdownMenuItem(
        value: _subCategoryItems[i].subCategoryId,
        child: Text(_subCategoryItems[i].subCategoryName.toString()),
      ));
    }
    return items;
  }

  // Load Brand in dropdownitems
  List<DropdownMenuItem<int>> _buildBrandItems() {
    print('Load Brands');
    print(_brandItems);
    List<DropdownMenuItem<int>> items = List.empty(growable: true);
    for (var i = 0; i < _brandItems.length; i++) {
      items.add(DropdownMenuItem(
        value: _brandItems[i].brandId,
        child: Text(_brandItems[i].brandName.toString()),
      ));
    }
    return items;
  }

  /// Save Data
  Future<void> saveCategory() async {
    // try {
    //   CommonResponseModel response = await CategoryRequest().addCategories({
    //     'category_id': widget.productId,
    //     'category_name': _mainProductField.text,
    //     'category_description': _categoryDesc.text,
    //     'sub_categories': _addSubCategory.toList()
    //   });

    //   setState(() {
    //     responseMessage = response.msg.toString();
    //     isSuccess = response.isSuccess;
    //   });
    //   // ignore: empty_catches
    // } on DioError catch (e) {
    //   throw Exception(e);
    // }
  }

  @override
  void initState() {
    super.initState();
    showFormInfo();
    loadPicklistData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            WillPopScope(
              onWillPop: () async {
                final shouldPop = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                            "Are you sure you want to abandon the form? Any changes will be lost."),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text("Cancel"),
                            onPressed: () => Navigator.pop(context, false),
                          ),
                          ElevatedButton(
                            child: const Text("Abandon"),
                            onPressed: () => Navigator.pop(context, true),
                          ),
                        ],
                      );
                    });
                return shouldPop!;
              },
              child: Form(
                key: _mainFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      GDropdown(
                          dropdownMenuItemList: _buildBrandItems(),
                          dropdownLabel: 'Brand',
                          onChanged: (value) {},
                          selectedValue: 1),
                      const SizedBox(
                        height: 20,
                      ),
                      GTextField(
                        editingController: _mainProductField,
                        changeFn: (value) {},
                        fieldLabel: 'Product name',
                        isObsureText: false,
                        onValidate: (value) {
                          if (value == '') {
                            return 'Please enter a product name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GDropdown(
                          dropdownMenuItemList: _buildSubCategory(),
                          dropdownLabel: 'Category',
                          onChanged: (value) {},
                          selectedValue: 1),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'List Of Product Items',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                _currentIndex = '';
                                _subCategoryField.text = '';
                                setState(() {});
                                formBottomSheet(context, 0);
                              },
                              child: const Text('Add Product Items')),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      _addSubCategory.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: _addSubCategory.length,
                              itemBuilder: (context, index) {
                                return SettingListCard(
                                  listItems: [
                                    Text(
                                      _addSubCategory[index]
                                          .productDetailName
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left,
                                    )
                                  ],
                                  actionItems: [
                                    IButton(
                                        onClick: () async {
                                          if (kDebugMode) {}
                                          _subCategoryField.text =
                                              _addSubCategory[index]
                                                  .productDetailName
                                                  .toString();
                                          _currentIndex = _addSubCategory[index]
                                              .productDetailId
                                              .toString();
                                          formBottomSheet(
                                              context, _currentIndex);
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
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              'Cancel')),
                                                      ElevatedButton(
                                                          onPressed: () async {
                                                            var subCategoryId =
                                                                _addSubCategory[
                                                                        index]
                                                                    .productDetailId
                                                                    .toString();
                                                            if (subCategoryId
                                                                .startsWith(
                                                                    '1111')) {
                                                              _addSubCategory.removeWhere(
                                                                  (element) =>
                                                                      element
                                                                          .productDetailId ==
                                                                      int.tryParse(
                                                                          subCategoryId));
                                                              setState(() {});
                                                              if (!mounted) {
                                                                return;
                                                              }
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            } else {
                                                              final response =
                                                                  await CategoryRequest()
                                                                      .deleteSubCategoryData({
                                                                'sub_category_id':
                                                                    subCategoryId
                                                              });
                                                              if (response
                                                                  .isSuccess!) {
                                                                _addSubCategory.removeWhere((element) =>
                                                                    element
                                                                        .productDetailId ==
                                                                    int.tryParse(
                                                                        subCategoryId));
                                                                setState(() {});
                                                                if (!mounted) {
                                                                  return;
                                                                }
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              }
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Sure'))
                                                    ],
                                                    content: const Text(
                                                        'Are you sure want to delete?'));
                                              });
                                        },
                                        icon: const Icon(Icons.delete))
                                  ],
                                );
                              },
                            )
                          : const Center(
                              child: Text('No sub category'),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              color: Colors.amber,
              height: 50,
              child: Center(
                child: ElevBtn(
                    btnText: 'Save',
                    color: Colors.blue,
                    onPressed: () async {
                      if (_mainFormKey.currentState!.validate()) {
                        for (var i = 0; i < _addSubCategory.length; i++) {
                          //     _subCategory.add(_addSubCategory[i].toJson());
                        }
                        await saveCategory();
                        if (!mounted) return;
                        showSnackBar(context, responseMessage.toString());
                        if (isSuccess!) {
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.pop(context, true);
                          });
                        }
                      }
                    }),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Future<dynamic> formBottomSheet(BuildContext context, index) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (__) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GTextField(
                      editingController: _subCategoryField,
                      changeFn: (value) {},
                      fieldLabel: 'Enter a product details',
                      isObsureText: false,
                      onValidate: (value) {
                        if (value == '') {
                          return 'Please enter a product details';
                        }
                        return null;
                      },
                    ),
                    ElevBtn(
                        btnText: 'Add',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (index != 0) {
                              var i = _addSubCategory.indexWhere((element) {
                                return element.productDetailId ==
                                    int.tryParse(index);
                              });
                              // _addSubCategory[i] = ProductEditFormData(
                              //     subCategoryId: int.parse(_currentIndex),
                              //     subCategoryName: _subCategoryField.text);
                            } else {
                              _currentIndex =
                                  (index != 0 ? index : randomNumber());
                              // _addSubCategory.add(CategoryEditFormData(
                              //     subCategoryId: int.parse(_currentIndex),
                              //     subCategoryName: _subCategoryField.text));
                            }
                            setState(() {});

                            _formKey.currentState!.reset();
                            Navigator.of(context).pop();
                          }
                        },
                        color: Colors.blue),
                  ],
                )),
          );
        });
  }

  String randomNumber() {
    var random = Random().nextInt(10) + 5;
    return '1111$random';
  }
}
