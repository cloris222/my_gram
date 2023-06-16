// To parse this JSON data, do
//
//     final userInfoData = userInfoDataFromJson(jsonString);

import 'dart:convert';

class UserInfoData {
  final String userId;
  final String email;
  final String country;
  final String ip;
  final String memberAvatarImageUrl;
  final List<Avatar> avatars;

  UserInfoData({
    required this.userId,
    required this.email,
    required this.country,
    required this.ip,
    required this.memberAvatarImageUrl,
    required this.avatars,
  });

  UserInfoData copyWith({
    String? userId,
    String? email,
    String? country,
    String? ip,
    String? memberAvatarImageUrl,
    List<Avatar>? avatars,
  }) =>
      UserInfoData(
        userId: userId ?? this.userId,
        email: email ?? this.email,
        country: country ?? this.country,
        ip: ip ?? this.ip,
        memberAvatarImageUrl: memberAvatarImageUrl ?? this.memberAvatarImageUrl,
        avatars: avatars ?? this.avatars,
      );

  factory UserInfoData.fromRawJson(String str) =>
      UserInfoData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfoData.fromJson(Map<String, dynamic> json) => UserInfoData(
        userId: json["userId"] ?? "",
        email: json["email"] ?? "",
        country: json["country"] ?? "",
        ip: json["ip"] ?? "",
        memberAvatarImageUrl: json["memberAvatarImageUrl"] ?? "",
        avatars: json["avatars"] != null
            ? List<Avatar>.from(json["avatars"].map((x) => Avatar.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "country": country,
        "ip": ip,
        "memberAvatarImageUrl": memberAvatarImageUrl,
        "avatars": List<dynamic>.from(avatars.map((x) => x.toJson())),
      };
}

class Avatar {
  final String type;
  final List<int> avatarIds;

  Avatar({
    required this.type,
    required this.avatarIds,
  });

  Avatar copyWith({
    String? type,
    List<int>? avatarIds,
  }) =>
      Avatar(
        type: type ?? this.type,
        avatarIds: avatarIds ?? this.avatarIds,
      );

  factory Avatar.fromRawJson(String str) => Avatar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        type: json["type"] ?? "",
        avatarIds: json["avatarIds"] != null
            ? List<int>.from(json["avatarIds"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "avatarIds": List<dynamic>.from(avatarIds.map((x) => x)),
      };
}
