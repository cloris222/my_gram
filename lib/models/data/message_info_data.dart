class MessageInfoData {
  MessageInfoData({
    required this.context,
    this.time = '',
    this.isRead = true
  });
  List<String> context;
  String time;
  bool isRead;


  factory MessageInfoData.fromJson(Map<String, dynamic> json) => MessageInfoData(
    context:json["context"]
        ? List<String>.from(json["context"].map((x) => x))
        : [],
    time: json["name"] ?? "",
    isRead:json["isRead"] ?? true,
  );

  Map<String, dynamic> toJson() => {
    "context":List<dynamic>.from(context.map((x) => x)),
    "time": time,
    "isRead": isRead,
  };
}