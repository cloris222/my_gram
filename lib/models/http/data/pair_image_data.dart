// To parse this JSON data, do
//
//     final demoData = demoDataFromJson(jsonString);

import 'dart:convert';

PairImageData demoDataFromJson(String str) =>
    PairImageData.fromJson(json.decode(str));

String demoDataToJson(PairImageData data) => json.encode(data.toJson());

class PairImageData {
  PairImageData(
      {required this.images,
      required this.name,
      required this.context,
      this.age = 0,
      this.isMyGF = false});

  List<String> images;
  String name;
  String context;
  bool isMyGF;
  int age;

  factory PairImageData.fromJson(Map<String, dynamic> json) => PairImageData(
        images: json["images"]
            ? List<String>.from(json["images"].map((x) => x))
            : [],
        name: json["name"] ?? "",
        context: json["context"] ?? "",
        age: json["age"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x)),
        "name": name,
        "context": context,
        "age": age,
      };
}
