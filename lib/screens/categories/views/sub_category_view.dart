import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ordering_app/models/sub_category_model.dart';
import 'package:ordering_app/services/category/main_category.dart';

class SubCategoryView extends StatefulWidget {
  int? mainCategoryId;
  SubCategoryView({Key? key, required this.mainCategoryId}) : super(key: key);

  @override
  State<SubCategoryView> createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
  int? selectedSubItems;
  int? currentSelectedIndex = 0;
  List<SubCategoryItems> subCategories = [];
  Future<List<SubCategoryItems>?> loadSubCategory() async {
    try {
      final response =
          await CategoryRequest().getSubCategories(widget.mainCategoryId);

      if (kDebugMode) {
        print(widget.mainCategoryId);
      }
      subCategories = response.subCategory;
      setState(() {});
      return subCategories;
    } catch (e) {}
    return null;
  }

  @override
  void initState() {
    super.initState();
    loadSubCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('Sub category'),
        ),
        body: SafeArea(
          child: Row(
            children: [
              SizedBox(
                width: 130,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  color: Colors.white30,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: subCategories.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (kDebugMode) {
                              currentSelectedIndex = index;
                              selectedSubItems =
                                  subCategories[index].subCategoryId;
                              setState(() {});
                              print(subCategories[index].subCategoryId);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: (currentSelectedIndex == index)
                                ? const BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignInside,
                                            width: 5,
                                            color: Colors.deepPurple,
                                            style: BorderStyle.solid)))
                                : const BoxDecoration(),
                            child: Text(
                              subCategories[index].subCategoryName.toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: (currentSelectedIndex == index)
                                      ? Colors.deepPurple
                                      : Colors.black),
                            ),
                          ),
                        );
                      })),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.cyanAccent[200],
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text('Main Content')),
                ),
              )
            ],
          ),
        ));
  }
}
