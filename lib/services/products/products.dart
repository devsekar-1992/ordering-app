import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ordering_app/models/products/product_list_model.dart';
import 'package:ordering_app/models/uom/uom_common_model.dart';
import 'package:ordering_app/models/uom/uom_list_model.dart';
import 'package:ordering_app/services/api_client/api.dart';

class ProductRequest {
  /// Get Products List
  Future<ProductListModel> getProductList() async {
    try {
      final response = await Api().getRequest('/products/list', '');
      ProductListModel productListModel =
          ProductListModel.fromJson(response.data);

      return productListModel;
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception(e);
    }
  }

  /// Add Uom
  Future<UomCommonModel> saveUomData(postData) async {
    try {
      String? path = '';
      dynamic response = '';
      if (postData['uom_id'] == null) {
        path = '/uom/add';
        response = await Api().postRequest(path, postData);
      } else {
        path = '/uom/update';
        response = await Api().putRequest(path, postData);
      }
      return UomCommonModel.fromJson(response.data);
    } on DioError catch (e) {
      if (kDebugMode) {
        if (e.response?.statusCode == 401) {}
      }
      throw Exception(e);
    }
  }

  // Get Unit Information By Id
  Future<UomListModel> getUnitById(postData) async {
    try {
      final response = await Api().postRequest('/uom/unit', postData);
      return UomListModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  /// Delete Uom
  Future<UomCommonModel> deleteUomData(postData) async {
    try {
      final response = await Api().deleteRequest('/uom/delete', postData);
      return UomCommonModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
