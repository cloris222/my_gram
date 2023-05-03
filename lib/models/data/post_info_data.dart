class PostInfoData {
  PostInfoData({
    required this.context,
    required this.images
  });
  String context;
  List<String> images;


  factory PostInfoData.fromJson(Map<String, dynamic> json) => PostInfoData(
      context:json["context"]??"",
      images:json["images"]?List<String>.from(json["images"].map((x)=>x)):[],
  );

  Map<String, dynamic> toJson() => {
    "context":context,
    "images":List<dynamic>.from(images.map((x) => x)),
  };
}