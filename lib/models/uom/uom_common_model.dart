class UomCommonModel {
  String? msg;
  bool? isSuccess;
  UomCommonModel({this.msg, this.isSuccess});
  UomCommonModel.fromJson(Map<String, dynamic> json) {
    msg = (json['message'] != null) ? json['message'] : null;
    isSuccess = (json['success'] != null) ? json['success'] : null;
  }
}
