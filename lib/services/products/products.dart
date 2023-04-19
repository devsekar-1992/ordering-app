import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ordering_app/models/common_response_model.dart';
import 'package:ordering_app/models/products/product_list_model.dart';
import 'package:ordering_app/models/products/products_edit_form_model.dart';
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

  /// Get Categories Info By Id
  Future<ProductsEditFormModel> getProductsById(postData) async {
    try {
      final response = await Api().getRequest("/category/$postData", '');
      return ProductsEditFormModel.fromJson(response.data);
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

  /// Add Products
  Future<CommonResponseModel> addProducts(postData) async {
    try {
      String? path = '';
      dynamic response = '';
      if (postData['uom_id'] == null) {
        path = '/products/add';
        response = await Api().postRequest(path, postData);
      } else {
        path = '/productts/update';
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
}
