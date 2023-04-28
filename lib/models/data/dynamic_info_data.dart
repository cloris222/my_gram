class DynamicInfoData {
  DynamicInfoData({
    required this.avatar,
    required this.name,
    required this.time,
    required this.context,
    required this.images,
    required this.likes,
    required this.comments,
    this.isFollowing = true
  });
  String avatar;
  String name;
  String time;
  String context;
  List<String> images;
  String likes;
  String comments;
  bool isFollowing;



  factory DynamicInfoData.fromJson(Map<String, dynamic> json) => DynamicInfoData(
    avatar:json["avatar"]??"",
    name: json["name"] ?? "",
    time:json["time"]??"",
    context: json["context"] ?? "",
    images: json["images"]
        ? List<String>.from(json["images"].map((x) => x))
        : [],
    likes:json["likes"].numberCompatFormat()??"0",
    comments:json["comments"].numberCompatFormat()??"0",
    isFollowing: json["isFollowing"]??true
  );

  Map<String, dynamic> toJson() => {
    "avatar":avatar,
    "name": name,
    "time":time,
    "context": context,
    "images": List<dynamic>.from(images.map((x) => x)),
    "likes":likes,
    "comments":comments,
    "isFollowing":isFollowing
  };
}