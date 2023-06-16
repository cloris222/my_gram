// To parse this JSON data, do
//
//     final registerData = registerDataFromJson(jsonString);

import 'dart:convert';

class RegisterData {
  final String email;
  final String password;
  final String gender;
  final String areaCode;
  final String country;
  final String inviteCode;
  final String verifyCode;
  final String preferGender;

  RegisterData({
    this.email = "",
    this.password = "",
    this.gender = "",
    this.areaCode = "",
    this.country = "",
    this.inviteCode = "",
    this.verifyCode = "",
    this.preferGender = "",
  });

  RegisterData copyWith({
    String? email,
    String? password,
    String? gender,
    String? areaCode,
    String? country,
    String? inviteCode,
    String? verifyCode,
    String? preferGender,
  }) =>
      RegisterData(
        email: email ?? this.email,
        password: password ?? this.password,
        gender: gender ?? this.gender,
        areaCode: areaCode ?? this.areaCode,
        country: country ?? this.country,
        inviteCode: inviteCode ?? this.inviteCode,
        verifyCode: verifyCode ?? this.verifyCode,
        preferGender: preferGender ?? this.preferGender,
      );

  factory RegisterData.fromRawJson(String str) =>
      RegisterData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
        email: json["email"],
        password: json["password"],
        gender: json["gender"],
        areaCode: json["areaCode"],
        country: json["country"],
        inviteCode: json["inviteCode"],
        verifyCode: json["verifyCode"],
        preferGender: json["preferGender"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "gender": gender,
        "areaCode": areaCode,
        "country": country,
        "inviteCode": inviteCode,
        "verifyCode": verifyCode,
        "preferGender": preferGender,
      };
}
