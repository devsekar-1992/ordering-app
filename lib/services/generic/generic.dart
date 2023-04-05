import 'package:dio/dio.dart';
import 'package:ordering_app/models/picklist/picklist_model.dart';
import 'package:ordering_app/services/api_client/api.dart';

class GenericRequest {
  /// Get dropdown
  Future<PicklistModel> getPicklistData() async {
    try {
      final response = await Api().getRequest('/ui/products', '');
      PicklistModel picklistModel = PicklistModel.fromJson(response.data);
      return picklistModel;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
