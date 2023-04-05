import 'package:flutter/foundation.dart';

class PicklistModel {
  String? msg;
  bool? isSuccess;
  List<SubCategory> subCategoryItems = [];
  List<Brand> brandItems = [];
  PicklistModel(
      {this.msg,
      this.isSuccess,
      required this.subCategoryItems,
      required this.brandItems});
  PicklistModel.fromJson(Map<String, dynamic> json) {
    msg = (json['message'] != null) ? json['message'] : null;
    if (json['data'] != null) {
      if (kDebugMode) {
        json['data'].forEach((value) => {
              value['sub_category'].forEach((v) => {
                    subCategoryItems.add(SubCategory(
                        subCategoryId: v['p_sub_category_id'],
                        subCategoryName: v['p_sub_category_name']))
                  }),
              value['brand'].forEach((v) => {
                    brandItems.add(Brand(
                        brandId: v['brand_id'], brandName: v['brand_name']))
                  })
            });
      }
    }
  }
}

/// Sub category Class
class SubCategory {
  int? subCategoryId;
  String? subCategoryName;
  SubCategory({required this.subCategoryId, required this.subCategoryName});
  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
      subCategoryId: json['p_sub_category_id'],
      subCategoryName: json['p_sub_category_name']);
}

/// Brand Name Class
class Brand {
  int? brandId;
  String? brandName;
  Brand({required this.brandId, required this.brandName});
  factory Brand.fromJson(Map<String, dynamic> json) =>
      Brand(brandId: json['brand_id'], brandName: json['brand_name']);
}
