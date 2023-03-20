class CategoryEditFormModel {
  String? msg;
  List<CategoryEditFormData> categoryEditData = [];
  CategoryEditFormModel({this.msg, required this.categoryEditData});
  CategoryEditFormModel.fromJson(Map<String, dynamic> json) {
    msg = (json['message'] != null) ? json['message'] : null;
    if (json['data'] != null) {
      if (json['data'].length > 0) {
        json['data'].forEach((value) => {
              value[0]['items'].forEach((v) =>
                  {categoryEditData.add(CategoryEditFormData.fromJson(v))})
            });
      }
    }
  }
}

class CategoryEditFormData {
  int? subCategoryId;
  String? subCategoryName;

  CategoryEditFormData(
      {required this.subCategoryId, required this.subCategoryName});
  factory CategoryEditFormData.fromJson(Map<String, dynamic> json) =>
      CategoryEditFormData(
          subCategoryId: json['p_sub_category_id'],
          subCategoryName: json['p_sub_category_name']);
}
