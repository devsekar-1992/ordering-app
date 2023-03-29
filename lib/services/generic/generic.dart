import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ordering_app/services/api_client/api.dart';

class GenericRequest {
  /// Get dropdown
  void getPicklistData() async {
    try {
      final response = await Api().getRequest('/ui/products', '');
      if (kDebugMode) {
        print(response);
      }
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
