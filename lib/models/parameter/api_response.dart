// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:base_project/constant/theme/global_data.dart';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  ApiResponse({
    required this.code,
    required this.message,
    this.data,
  });

  String code;
  String message;
  dynamic data;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
      code: json["code"], message: json["message"], data: json["data"]);

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data,
      };

  void printLog(){
    GlobalData.printLog('===========printLog===========');
    GlobalData.printLog('code:$code');
    GlobalData.printLog('message:$message');
    GlobalData.printLog('data:$data');
  }
}
