class MainCategoryModel {
  String? msg;
  List<MainCategoryItems> mainCategory = [];
  MainCategoryModel({this.msg, required this.mainCategory});

  MainCategoryModel.fromJson(Map<String, dynamic> json) {
    msg = (json['msg'] != null) ? json['msg'] : null;
    if (json['data'] != null) {
      if (json['data'].length > 0) {
        json['data'].forEach((value) => {print(value)});
        json['data'].forEach(
            (value) => {mainCategory.add(MainCategoryItems.fromJson(value))});
      }
    }
  }
}

class MainCategoryItems {
  int? pCategoryId;
  String? pCategoryName;

  MainCategoryItems({required this.pCategoryId, required this.pCategoryName});

  factory MainCategoryItems.fromJson(Map<String, dynamic> json) =>
      MainCategoryItems(
          pCategoryId: json['p_category_id'],
          pCategoryName: json['p_category_name']);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = pCategoryId;
    data['category_name'] = pCategoryName;
    return data;
  }
}
