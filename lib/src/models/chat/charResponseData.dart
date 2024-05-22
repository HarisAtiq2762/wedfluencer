// To parse this JSON data, do
//
//     final chatData = chatDataFromJson(jsonString);

import 'dart:convert';

import 'chatValue.dart';

ChatData chatDataFromJson(String str) => ChatData.fromJson(json.decode(str));

String chatDataToJson(ChatData data) => json.encode(data.toJson());

class ChatData {
  final List<String> activeUser;
  final Map<String, ChatValue>? chats;

  ChatData({
    required this.activeUser,
    this.chats,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) => ChatData(
        activeUser: List<String>.from(json["activeUser"]!.map((x) => x)),
        chats: Map.from(json["chats"]!).map(
            (k, v) => MapEntry<String, ChatValue>(k, ChatValue.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "activeUser": List<String>.from(activeUser.map((x) => x)),
        "chats": Map.from(chats!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}
