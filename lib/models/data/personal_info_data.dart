import 'package:base_project/models/data/post_info_data.dart';

class PersonalInfoData {
  PersonalInfoData({
    required this.avatar,
    required this.name,
    required this.totalPosts,
    required this.posts,
    required this.fans,
    required this.introduce,
    this.isFollowing = true,
    this.isShowMore = false
  });
  String avatar;
  String name;
  int totalPosts;
  List<PostInfoData> posts;
  List<String> fans;
  String introduce;
  bool isFollowing;
  bool isShowMore;


  factory PersonalInfoData.fromJson(Map<String, dynamic> json) => PersonalInfoData(
      avatar:json["avatar"]??"",
      name: json["name"] ?? "",
      totalPosts: json["totalPosts"]??0,
      posts:json["posts"]?List<PostInfoData>.from(json["posts"].map((x)=>x)):[],
      fans: json["fans"]?List<String>.from(json["fans"].map((x)=>x)):[],
      introduce: json["introduce"] ?? "",
      isFollowing: json["isFollowing"]??true,
      isShowMore: json["isShowMore"]??false
  );

  Map<String, dynamic> toJson() => {
    "avatar":avatar,
    "name": name,
    "totalPosts":totalPosts,
    "posts":List<dynamic>.from(posts.map((x) => x)),
    "fans": List<dynamic>.from(fans.map((x) => x)),
    "introduce":introduce,
    "isFollowing":isFollowing,
    "isShowMore":isShowMore
  };
}