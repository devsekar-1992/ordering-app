class CommonResponseModel {
  String? msg;
  bool? isSuccess;
  CommonResponseModel({this.msg, this.isSuccess});
  CommonResponseModel.fromJson(Map<String, dynamic> json) {
    msg = (json['message'] != null) ? json['message'] : null;
    isSuccess = (json['success'] != null) ? json['success'] : null;
  }
}
