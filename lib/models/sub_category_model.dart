class SubCategoryModel {
  String? msg;
  List<SubCategoryItems> subCategory = [];
  SubCategoryModel({this.msg, required this.subCategory});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    msg = (json['msg'] != null) ? json['msg'] : null;
    if (json['data'] != null) {
      if (json['data'].length > 0) {
        json['data'].forEach(
            (value) => {subCategory.add(SubCategoryItems.fromJson(value))});
      }
    }
  }
}

class SubCategoryItems {
  int? subCategoryId;
  int? pCategoryId;
  String? subCategoryName;

  SubCategoryItems(
      {required this.subCategoryId,
      required this.pCategoryId,
      required this.subCategoryName});

  factory SubCategoryItems.fromJson(Map<String, dynamic> json) =>
      SubCategoryItems(
          subCategoryId: json['p_sub_category_id'],
          pCategoryId: json['p_category_id'],
          subCategoryName: json['p_sub_category_name']);
}
