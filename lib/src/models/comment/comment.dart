import 'dart:convert';

class Comment {
  final String id;
  final String comment;

  Comment({
    required this.id,
    required this.comment,
  });

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
      };
}
