import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ordering_app/models/categories/categories_edit_form_model.dart';
import 'package:ordering_app/models/common_response_model.dart';
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

  /// Add Uom
  Future<CommonResponseModel> addCategories(postData) async {
    try {
      String? path = '';
      dynamic response = '';
      if (postData['uom_id'] == null) {
        path = '/category/add';
        response = await Api().postRequest(path, postData);
      } else {
        path = '/category/update';
        response = await Api().putRequest(path, postData);
      }
      return CommonResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      if (kDebugMode) {
        if (e.response?.statusCode == 401) {}
      }
      throw Exception(e);
    }
  }

  /// Get Categories Info By Id
  Future<CategoryEditFormModel> getCategoriesById(postData) async {
    try {
      final response = await Api().getRequest("/category/$postData", '');
      return CategoryEditFormModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
