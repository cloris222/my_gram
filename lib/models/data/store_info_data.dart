import 'dynamic_info_data.dart';

class StoreInfoData {
  StoreInfoData({
    required this.avatar,
    required this.name,
    required this.list
  });
  String avatar;
  String name;
  List<DynamicInfoData> list;


  factory StoreInfoData.fromJson(Map<String, dynamic> json) => StoreInfoData(
    avatar:json["avatar"]??"",
    name: json["name"] ?? "",
    list: json["list"]
        ? List<DynamicInfoData>.from(json["images"].map((x) => x))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "avatar":avatar,
    "name": name,
    "list": List<dynamic>.from(list.map((x) => x)),
  };
}