// To parse this JSON data, do
//
//     final postCommentData = postCommentDataFromJson(jsonString);

import 'dart:convert';

PostCommentData postCommentDataFromJson(String str) =>
    PostCommentData.fromJson(json.decode(str));

String postCommentDataToJson(PostCommentData data) =>
    json.encode(data.toJson());

class PostCommentData {
  PostCommentData({
    required this.commentId,
    required this.replyId,
    required this.avatarUrl,
    required this.userName,
    required this.commentContext,
    required this.likes,
    required this.isLike,
    this.subCommentList,
  });

  final String commentId;
  final String replyId;
  final String avatarUrl;
  final String userName;
  final String commentContext;
  int likes;
  bool isLike;
  List<PostCommentData>? subCommentList;

  factory PostCommentData.fromJson(Map<String, dynamic> json) =>
      PostCommentData(
        commentId: json["commentId"] ?? "",
        replyId: json["replyId"] ?? "",
        avatarUrl: json["avatarUrl"] ?? "",
        userName: json["userName"] ?? "",
        commentContext: json["commentContext"] ?? "",
        likes: json["likes"] ?? 0,
        isLike: json["isLike"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "replyId": replyId,
        "avatarUrl": avatarUrl,
        "userName": userName,
        "commentContext": commentContext,
        "likes": likes,
        "isLike": isLike,
      };

  /// 當無回應id時 代表為第一層
  bool isMainComment() {
    return replyId.isEmpty;
  }

  void onToggleLike() {
    /// 如果喜歡的話一定會有個愛心
    likes = likes + (isLike ? -1 : 1);
    isLike = !isLike;
  }
}
