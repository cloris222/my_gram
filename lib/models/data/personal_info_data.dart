class PersonalInfoData {
  PersonalInfoData({
    required this.avatar,
    required this.name,
    required this.posts,
    required this.fans,
    required this.introduce,
    required this.images,
    this.isFollowing = true,
    this.isShowMore = false
  });
  String avatar;
  String name;
  List<String> posts;
  List<String> fans;
  String introduce;
  List<String> images;
  bool isFollowing;
bool isShowMore;


  factory PersonalInfoData.fromJson(Map<String, dynamic> json) => PersonalInfoData(
    avatar:json["avatar"]??"",
    name: json["name"] ?? "",
      posts:json["posts"]?List<String>.from(json["posts"].map((x)=>x)):[],
    fans: json["fans"]?List<String>.from(json["fans"].map((x)=>x)):[],
    introduce: json["introduce"] ?? "",
    images: json["images"]
        ? List<String>.from(json["images"].map((x) => x))
        : [],
    isFollowing: json["isFollowing"]??true,
    isShowMore: json["isShowMore"]??false
  );

  Map<String, dynamic> toJson() => {
    "avatar":avatar,
    "name": name,
    "posts":List<dynamic>.from(posts.map((x) => x)),
    "fans": List<dynamic>.from(fans.map((x) => x)),
    "introduce":introduce,
    "images": List<dynamic>.from(images.map((x) => x)),
    "isFollowing":isFollowing,
    "isShowMore":isShowMore
  };
}