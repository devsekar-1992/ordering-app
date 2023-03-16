import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ordering_app/widgets/g_button.dart';
import 'package:ordering_app/widgets/g_icon_button.dart';
import 'package:ordering_app/widgets/g_setting_list_card.dart';
import 'package:ordering_app/widgets/g_text.dart';

class CategoriesSettingsForm extends StatefulWidget {
  final int? categoryId;
  const CategoriesSettingsForm({Key? key, required this.categoryId})
      : super(key: key);

  @override
  State<CategoriesSettingsForm> createState() => _CategoriesSettingsFormState();
}

class _CategoriesSettingsFormState extends State<CategoriesSettingsForm> {
  final List _addSubCategory = [];
  final _mainCategoryField = TextEditingController();
  final _subCategoryField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _currentIndex = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GTextField(
                editingController: _mainCategoryField,
                changeFn: (value) {},
                fieldLabel: 'Enter a category',
                isObsureText: false,
                onValidate: (value) {
                  if (value == '') {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'List Of Sub Categories',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _currentIndex = '';
                        _subCategoryField.text = '';
                        setState(() {});
                        formBottomSheet(context, 0);
                      },
                      child: const Text('Add Sub category')),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: _addSubCategory.length,
                itemBuilder: (context, index) {
                  return _addSubCategory.isNotEmpty
                      ? SettingListCard(
                          listItems: [
                            Text(
                              _addSubCategory[index]['sub_category'].toString(),
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )
                          ],
                          actionItems: [
                            IButton(
                                onClick: () async {
                                  if (kDebugMode) {}
                                  _subCategoryField.text =
                                      _addSubCategory[index]['sub_category'];
                                  _currentIndex = _addSubCategory[index]['id'];
                                  formBottomSheet(
                                      context, _addSubCategory[index]['id']);
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
                                                    // final response =
                                                    //     await ProductRequest()
                                                    //         .deleteUomData(
                                                    //             {'uom_id': uomId});
                                                    // if (response.isSuccess!) {
                                                    //   productListItems.removeWhere(
                                                    //       (element) =>
                                                    //           element.productId ==
                                                    //           productListItems[index]
                                                    //               .productId);
                                                    //   setState(() {});
                                                    //   Navigator.of(context).pop();
                                                    // }
                                                  },
                                                  child: const Text('Sure'))
                                            ],
                                            content: const Text(
                                                'Are you sure want to delete?'));
                                      });
                                },
                                icon: const Icon(Icons.delete))
                          ],
                        )
                      : const Center(
                          child: Text('No sub category'),
                        );
                },
              )
            ],
          ),
        ),
      ),
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
                      fieldLabel: 'Enter a sub category',
                      isObsureText: false,
                      onValidate: (value) {
                        if (value == '') {
                          return 'Please enter a sub category';
                        }
                        return null;
                      },
                    ),
                    ElevBtn(
                        btnText: 'Add',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_currentIndex != '') {
                              _addSubCategory.map((e) => (e['id'] ==
                                      _currentIndex)
                                  ? e['sub_category'] = _subCategoryField.text
                                  : '');
                              _addSubCategory[_addSubCategory.indexWhere(
                                  (element) =>
                                      element['id'] == _currentIndex)] = {
                                'id': _currentIndex,
                                'sub_category': _subCategoryField.text
                              };
                              print(_addSubCategory);
                            } else {
                              _addSubCategory.add({
                                'id': _currentIndex != ''
                                    ? _currentIndex
                                    : randomNumber(),
                                'sub_category': _subCategoryField.text
                              });
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
    return '000A$random';
  }
}
