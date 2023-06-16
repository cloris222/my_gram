// To parse this JSON data, do
//
//     final apiSecretKey = apiSecretKeyFromJson(jsonString);

import 'dart:convert';

class ApiSecretKey {
  final String apiSecretKey;
  final String publicKey;
  String encodeContext;

  ApiSecretKey({
    required this.apiSecretKey,
    required this.publicKey,
    this.encodeContext="",
  });

  ApiSecretKey copyWith({
    String? apiSecretKey,
    String? publicKey,
  }) =>
      ApiSecretKey(
        apiSecretKey: apiSecretKey ?? this.apiSecretKey,
        publicKey: publicKey ?? this.publicKey,
      );

  factory ApiSecretKey.fromRawJson(String str) =>
      ApiSecretKey.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiSecretKey.fromJson(Map<String, dynamic> json) => ApiSecretKey(
        apiSecretKey: json["apiSecretKey"] ?? "",
        publicKey: json["publicKey"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "apiSecretKey": apiSecretKey,
        "publicKey": publicKey,
      };
}
