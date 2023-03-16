class UomListModel {
  String? msg;
  List<UomListData> uomListData = [];
  UomListModel({this.msg, required this.uomListData});
  UomListModel.fromJson(Map<String, dynamic> json) {
    msg = (json['message'] != null) ? json['message'] : null;
    if (json['data'] != null) {
      if (json['data'].length > 0) {
        json['data']
            .forEach((value) => {uomListData.add(UomListData.fromJson(value))});
      }
    }
  }
}

class UomListData {
  int? uomId;
  String? uomName;
  String? uomDescription;

  UomListData(
      {required this.uomId,
      required this.uomName,
      required this.uomDescription});
  factory UomListData.fromJson(Map<String, dynamic> json) => UomListData(
      uomId: json['uom_id'],
      uomName: json['uom_name'],
      uomDescription: json['uom_description']);
}
