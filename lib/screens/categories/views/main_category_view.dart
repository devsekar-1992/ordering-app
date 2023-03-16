import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ordering_app/models/main_category_model.dart';
import 'package:ordering_app/screens/categories/views/sub_category_view.dart';
import 'package:ordering_app/services/category/main_category.dart';

class MainCategory extends StatefulWidget {
  @override
  State<MainCategory> createState() => _MainCategoryState();
}

class _MainCategoryState extends State<MainCategory> {
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
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: false,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Shop By Category',
                style: TextStyle(color: Colors.white),
              ),
              background: Image.network(
                'https://images.unsplash.com/photo-1515706886582-54c73c5eaf41?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFillRemaining(
            child: GridView.builder(
              padding: const EdgeInsets.all(30.0),
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 4 / 2,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20),
              itemCount: categoryItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (kDebugMode) {
                      print(categoryItems[index].pCategoryId);
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubCategoryView(
                                mainCategoryId:
                                    categoryItems[index].pCategoryId)));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 241, 183, 202),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      categoryItems[index].pCategoryName.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
