class MessageInfoData {
  MessageInfoData({
    required this.context,
    this.time = '',
    this.isRead = false,
    this.beRead = false
  });
  String context;
  String time;
  bool beRead;
  bool isRead;


  factory MessageInfoData.fromJson(Map<String, dynamic> json) => MessageInfoData(
    context:json["context"]??"",
    time: json["name"] ?? "",
    isRead:json["isRead"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "context":context,
    "time": time,
    "isRead": isRead,
  };
}