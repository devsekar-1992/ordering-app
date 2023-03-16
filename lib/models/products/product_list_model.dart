class ProductListModel {
  bool? isSuccess;
  String? msg;
  List<ProductListData> productListData = [];
  ProductListModel({this.msg, required this.productListData});
  ProductListModel.fromJson(Map<String, dynamic> json) {
    msg = (json['message'] != null) ? json['message'] : null;
    isSuccess = (json['success'] != null) ? json['success'] : null;
    if (json['data'] != null) {
      if (json['data'].length > 0) {
        json['data'].forEach(
            (value) => {productListData.add(ProductListData.fromJson(value))});
      }
    }
  }
}

class ProductListData {
  int? productId;
  String? productName;
  String? productCategory;
  String? productCount;

  ProductListData(
      {required this.productId,
      required this.productName,
      required this.productCategory,
      required this.productCount});
  factory ProductListData.fromJson(Map<String, dynamic> json) =>
      ProductListData(
          productId: json['p_item_id'],
          productName: json['p_item_name'],
          productCategory: json['p_sub_category_name'],
          productCount: json['cnt']);
}
