// To parse this JSON data, do
//
//     final demoData = demoDataFromJson(jsonString);

import 'dart:convert';

PairImageData demoDataFromJson(String str) =>
    PairImageData.fromJson(json.decode(str));

String demoDataToJson(PairImageData data) => json.encode(data.toJson());

class PairImageData {
  PairImageData({
    required this.images,
    required this.name,
    required this.context,
  });

  List<String> images;
  String name;
  String context;

  factory PairImageData.fromJson(Map<String, dynamic> json) => PairImageData(
        images: json["images"]
            ? List<String>.from(json["images"].map((x) => x))
            : [],
        name: json["name"] ?? "",
        context: json["context"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x)),
        "name": name,
        "context": context,
      };
}
