class ProductsEditFormModel {
  String? msg;
  int? productCompanyId;
  int? productCategoryId;
  String? mainProductName;
  int? mainProductId;
  List<ProductEditFormData> productEditData = [];
  ProductsEditFormModel({this.msg, required this.productEditData});
  ProductsEditFormModel.fromJson(Map<String, dynamic> json) {
    msg = (json['message'] != null) ? json['message'] : null;
    if (json['data'] != null) {
      if (json['data'].length > 0) {
        json['data'].forEach((value) => {
              mainProductName = value[0]['p_item_name'],
              mainProductId = value[0]['category_id'],
              value[0]['items'].forEach(
                  (v) => {productEditData.add(ProductEditFormData.fromJson(v))})
            });
      }
    }
  }
}

class ProductEditFormData {
  int? productDetailId;
  String? productDetailName;
  int? uomId;
  String? hsnCode;
  int? cgstEnable;
  int? sgstEnable;

  ProductEditFormData(
      {required this.productDetailId,
      required this.productDetailName,
      required this.hsnCode,
      required this.uomId,
      required this.sgstEnable,
      required this.cgstEnable});
  factory ProductEditFormData.fromJson(Map<String, dynamic> json) =>
      ProductEditFormData(
          productDetailId: json['p_item_detail_id'],
          productDetailName: json['p_item_detail_name'],
          uomId: json['p_uom'],
          hsnCode: json['p_hsn_code'],
          cgstEnable: json['is_cgst_enable'],
          sgstEnable: json['is_sgst_enable']);
  Map toJson() => {
        'item_detail_id': productDetailId,
        'item_detail_name': productDetailName,
        'hsn_code': hsnCode,
        'uom_id': uomId,
        'is_cgst_enable': cgstEnable,
        'is_sgst_enable': sgstEnable
      };
}
