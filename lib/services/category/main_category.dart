import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ordering_app/models/main_category_model.dart';
import 'package:ordering_app/models/sub_category_model.dart';
import 'package:ordering_app/services/api_client/api.dart';

class CategoryRequest {
  Future<MainCategoryModel> getCategories() async {
    try {
      final response = await Api().getRequest('/category/list', '');
      MainCategoryModel mainCatModel =
          MainCategoryModel.fromJson(response.data);

      return mainCatModel;
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception(e);
    }
  }

  Future<SubCategoryModel> getSubCategories(categoryId) async {
    try {
      final response = await Api()
          .getRequest('/subcategory/list', {'category_id': categoryId});
      SubCategoryModel subCatModel = SubCategoryModel.fromJson(response.data);
      return subCatModel;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
