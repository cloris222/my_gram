// To parse this JSON data, do
//
//     final createAiInfo = createAiInfoFromJson(jsonString);

import 'dart:convert';

class CreateAiInfo {
  final String id;
  final String avatarId;
  final List<String> feature;
  final String prompt;
  final String type;
  final String imgUrl;

  CreateAiInfo({
    required this.id,
    required this.avatarId,
    required this.feature,
    required this.prompt,
    required this.type,
    required this.imgUrl,
  });

  CreateAiInfo copyWith({
    String? id,
    String? avatarId,
    List<String>? feature,
    String? prompt,
    String? type,
    String? imgUrl,
  }) =>
      CreateAiInfo(
        id: id ?? this.id,
        avatarId: avatarId ?? this.avatarId,
        feature: feature ?? this.feature,
        prompt: prompt ?? this.prompt,
        type: type ?? this.type,
        imgUrl: imgUrl ?? this.imgUrl,
      );

  factory CreateAiInfo.fromRawJson(String str) =>
      CreateAiInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateAiInfo.fromJson(Map<String, dynamic> json) => CreateAiInfo(
        id: json["id"] ?? "",
        avatarId: json["avatarId"] ?? "",
        feature: json["feature"] != null
            ? List<String>.from(json["feature"].map((x) => x))
            : [],
        prompt: json["prompt"] ?? "",
        type: json["type"] ?? "",
        imgUrl: json["imgUrl"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatarId": avatarId,
        "feature": List<dynamic>.from(feature.map((x) => x)),
        "prompt": prompt,
        "type": type,
        "imgUrl": imgUrl,
      };
}
