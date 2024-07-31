import 'dart:convert';

class Comment {
  final int numberOfReplies;
  final String userName;
  final String userId;
  final String postId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String comment;

  Comment({
    required this.numberOfReplies,
    required this.userName,
    required this.userId,
    required this.postId,
    required this.createdAt,
    required this.updatedAt,
    required this.comment,
  });

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        numberOfReplies: json["numberOfReplies"],
        userName: json["userName"],
        userId: json["userId"],
        postId: json["postId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "numberOfReplies": numberOfReplies,
        "userName": userName,
        "userId": userId,
        "postId": postId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "comment": comment,
      };
}
