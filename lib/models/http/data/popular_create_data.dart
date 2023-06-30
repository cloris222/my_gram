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

  factory PopularCreateData.fromJson(Map<String, dynamic> json) => PopularCreateData(
        id: json["id"],
        avatarId: json["avatarId"],
        feature: json["feature"],
        prompt: json["prompt"],
        type: json["type"],
        imgUrl: json["imgUrl"],
      );
    
}