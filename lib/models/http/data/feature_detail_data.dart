// To parse this JSON data, do
//
//     final featureDetailData = featureDetailDataFromJson(jsonString);

import 'dart:convert';

class FeatureDetailData {
  final String feature;
  final String tag;
  final String prompt;
  final String name;
  final String status;
  final String imgUrl;

  bool get enable => (status == "ENABLE");

  FeatureDetailData({
    required this.feature,
    required this.tag,
    required this.prompt,
    required this.name,
    required this.status,
    required this.imgUrl,
  });

  FeatureDetailData copyWith({
    String? feature,
    String? tag,
    String? prompt,
    String? name,
    String? status,
    String? imgUrl,
  }) =>
      FeatureDetailData(
        feature: feature ?? this.feature,
        tag: tag ?? this.tag,
        prompt: prompt ?? this.prompt,
        name: name ?? this.name,
        status: status ?? this.status,
        imgUrl: imgUrl ?? this.imgUrl,
      );

  factory FeatureDetailData.fromRawJson(String str) =>
      FeatureDetailData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FeatureDetailData.fromJson(Map<String, dynamic> json) =>
      FeatureDetailData(
        feature: json["feature"] ?? "",
        tag: json["tag"] ?? "",
        prompt: json["prompt"] ?? "",
        name: json["name"] ?? "",
        status: json["status"] ?? "",
        imgUrl: json["imgUrl"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "feature": feature,
        "tag": tag,
        "prompt": prompt,
        "name": name,
        "status": status,
        "imgUrl": imgUrl,
      };
}
