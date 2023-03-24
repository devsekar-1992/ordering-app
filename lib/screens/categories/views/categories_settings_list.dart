import 'package:flutter/material.dart';
import 'package:ordering_app/models/main_category_model.dart';
import 'package:ordering_app/screens/categories/views/categories_settings_form.dart';
import 'package:ordering_app/services/category/main_category.dart';
import 'package:ordering_app/widgets/g_icon_button.dart';
import 'package:ordering_app/widgets/g_setting_list_card.dart';

class CategorySettingsList extends StatefulWidget {
  const CategorySettingsList({Key? key}) : super(key: key);

  @override
  State<CategorySettingsList> createState() => _CategorySettingsListState();
}

class _CategorySettingsListState extends State<CategorySettingsList> {
  List<MainCategoryItems> categoryItems = [];
  Future<MainCategoryItems?> loadCategory() async {
    final response = await CategoryRequest().getCategories();
    categoryItems = response.mainCategory;
    setState(() {});
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        title: const Text('Category'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CategoriesSettingsForm(
                        categoryId: null,
                      ))).then((value) => loadCategory());
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
                itemCount: categoryItems.length,
                itemBuilder: (context, index) {
                  return SettingListCard(listItems: [
                    Text(
                      categoryItems[index].pCategoryName.toString(),
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )
                  ], actionItems: [
                    IButton(
                        onClick: () async {
                          final categoryId = categoryItems[index].pCategoryId;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoriesSettingsForm(
                                        categoryId: categoryId,
                                      ))).then((value) => loadCategory());
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
                                            final categoryId =
                                                categoryItems[index]
                                                    .pCategoryId;
                                            final response =
                                                await CategoryRequest()
                                                    .deleteCategoryData({
                                              'category_id': categoryId
                                            });
                                            if (response.isSuccess!) {
                                              categoryItems.removeWhere(
                                                  (element) =>
                                                      element.pCategoryId ==
                                                      categoryId);
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
