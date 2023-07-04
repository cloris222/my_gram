import 'dart:convert';

class PopularCreateData {
  final String id;
  final String avatarId;
  final List<String> feature;
  final String prompt;
  final String type;
  final String imgUrl;

  PopularCreateData({
    required this.id,
    required this.avatarId,
    required this.feature,
    required this.prompt,
    required this.type,
    required this.imgUrl,
  });

  factory PopularCreateData.fromJson(Map<String, dynamic> json) {
    List<String> featureList = json["feature"] != null ? List<String>.from(json["feature"].map((e) => e)) : [];

    return PopularCreateData(
      id: json["id"].toString(),
      avatarId: json["avatarId"].toString(),
      feature: featureList,
      prompt: json["prompt"],
      type: json["type"],
      imgUrl: json["imgUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatarId": avatarId,
        "feature": List<dynamic>.from(feature.map((e) => e)),
        "prompt": prompt,
        "type": type,
        "imgUrl": imgUrl,
      };
}
