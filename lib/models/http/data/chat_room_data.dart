import 'package:photo_manager/photo_manager.dart';

class ChatRoomData {
  ChatRoomData(
      {this.roomId = '',
        this.uId = '',
        this.nickName = '',
        this.avatar = '',
        this.memberId = '',
        this.myMemberId = '',
        this.unreadCount = '',
        this.content = '',
        this.contentId = '',
        this.time = '',
        this.pushStatus = '',
        this.readTimeStatus = '',
        this.isFollowing = true,
        this.isImage = false,
        this.isBlock = false,
        this.isRead = false,
        this.beRead = false,
        this.isPin = false,
        required this.imageList
      });

  String roomId; // 鍵值 聊天室編號
  String uId; // 對方uid
  String nickName; // 對方暱稱
  String avatar; // 對方頭像
  String memberId; // 對方的會員編號
  String myMemberId; // 我的會員編號
  String content; // 訊息內容
  String contentId; // 最新訊息的id
  String unreadCount; // 未讀數量
  String pushStatus; // 通知狀態 enable / disable
  String time; // yyyy/mm/dd hh:mm:ss.sss
  String readTimeStatus; // 已讀狀態是否打開
  bool isFollowing; // 我對他的 追蹤狀態
  bool  isImage; // true: 傳圖片, false: 傳文字
  bool  isBlock; // 封鎖狀態
  bool beRead; //被已讀
  bool isRead; //已讀
  bool isPin;//釘選
  List<AssetEntity> imageList;//傳送的圖片（最多4張）

  factory ChatRoomData.fromJson(Map<String,dynamic> json) => ChatRoomData(
    roomId: json["roomId"] ?? '',
    uId: json["uId"] ?? '',
    nickName: json["nickName"] ?? '',
    avatar: json["avatar"] ?? '',
    memberId: json["memberId"] ?? '',
    myMemberId: json["myMemberId"] ?? '',
    content: json["content"] ?? '',
    contentId: json["contentId"] ?? '',
    unreadCount: json["unreadCount"] ?? '',
    pushStatus: json["pushStatus"] ?? '',
    time: json["time"] ?? '',
    readTimeStatus: json["readTimeStatus"] ?? '',
    isFollowing: json["isFollowing"] ?? true,
    isImage: json["isImage"] ?? false,
    isBlock: json["isBlock"] ?? false,
    beRead: json["beRead"] ?? false,
    isRead: json["isRead"] ?? false,
    isPin: json["isPin"] ?? false,
    imageList: json["imageList"] ? List<AssetEntity>.from(json["imageList"].map((x) => x)) : [],
  );

  Map<String, dynamic> toJson() {
    return {
      "roomId": roomId,
      "uId": uId,
      "nickName": nickName,
      "avatar": avatar,
      "memberId": memberId,
      "myMemberId": myMemberId,
      "content": content,
      "contentId": contentId,
      "time": time,
      "unreadCount": unreadCount,
      "pushStatus": pushStatus,
      "readTimeStatus": readTimeStatus,
      "isFollowing": isFollowing,
      "isImage": isImage,
      "isBlock": isBlock,
      "isRead": isRead,
      "beRead":beRead,
      "isPin":isPin,
      "imageList":List<dynamic>.from(imageList.map((x)=>x)),
    };
  }
}