class MessageInfoData {
  MessageInfoData({
    required this.context,
    this.time = '',
  });
  List<String> context;
  String time;


  factory MessageInfoData.fromJson(Map<String, dynamic> json) => MessageInfoData(
    context:json["context"]
        ? List<String>.from(json["context"].map((x) => x))
        : [],
    time: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "context":List<dynamic>.from(context.map((x) => x)),
    "time": time,
  };
}