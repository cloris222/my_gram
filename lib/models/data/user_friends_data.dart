import 'message_info_data.dart';

class UserFriendsData {
  UserFriendsData({
    this.isPin = false,
    required this.avatar,
    required this.name,
    required this.messageData,
    required this.userId,
  });
  String avatar;
  String name;
  bool isPin;
  List<MessageInfoData> messageData;
  int userId;


  factory UserFriendsData.fromJson(Map<String, dynamic> json) => UserFriendsData(
    avatar:json["avatar"]??"",
    name: json["name"] ?? "",
    isPin: json["isPin"]??false,
    messageData: json["messageData"]?List<MessageInfoData>.from(json["messageData"].map((x)=>x)):[],
    userId: json["avatar"]??"",
  );

  Map<String, dynamic> toJson() => {
    "avatar":avatar,
    "name": name,
    "isPin":isPin,
    "messageData":List<dynamic>.from(messageData.map((x)=>x)),
    "userId":userId
  };
}