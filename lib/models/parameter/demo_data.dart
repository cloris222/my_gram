// To parse this JSON data, do
//
//     final demoData = demoDataFromJson(jsonString);

import 'dart:convert';

DemoData demoDataFromJson(String str) => DemoData.fromJson(json.decode(str));

String demoDataToJson(DemoData data) => json.encode(data.toJson());

class DemoData {
  DemoData({
    required this.firstString,
    required this.secondNumber,
    required this.time,
  });

  String firstString;
  num secondNumber;
  DateTime time;

  factory DemoData.fromJson(Map<String, dynamic> json) => DemoData(
    firstString: json["firstString"],
    secondNumber: json["SecondNumber"],
    time: DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "firstString": firstString,
    "SecondNumber": secondNumber,
    "time": time.toIso8601String(),
  };
}
