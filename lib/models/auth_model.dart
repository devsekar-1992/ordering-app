import 'package:flutter/foundation.dart';

class AuthModel {
  String? msg;
  String? token;

  AuthModel({this.msg, this.token});

  AuthModel.fromJson(Map<String, dynamic> json) {
    msg = (json['msg'] != null) ? json['msg'] : null;
    token = json['tkn'];
  }
}
