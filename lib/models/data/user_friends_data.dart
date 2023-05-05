import 'message_info_data.dart';

class UserFriensData {
  UserFriensData({
    required this.avatar,
    required this.name,
    required this.messageData,
    this.isPin = false,
  });
  String avatar;
  String name;
  bool isPin;
  List<MessageInfoData> messageData;


  factory UserFriensData.fromJson(Map<String, dynamic> json) => UserFriensData(
    avatar:json["avatar"]??"",
    name: json["name"] ?? "",
    isPin: json["isPin"]??false,
    messageData: json["messageData"]?List<MessageInfoData>.from(json["messageData"].map((x)=>x)):[],
  );

  Map<String, dynamic> toJson() => {
    "avatar":avatar,
    "name": name,
    "isPin":isPin
  };
}