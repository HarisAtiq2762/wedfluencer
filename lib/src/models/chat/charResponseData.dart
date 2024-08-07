// To parse this JSON data, do
//
//     final chatData = chatDataFromJson(jsonString);

import 'package:wedfluencer/src/models/chat/vendorChat.dart';

import 'chatValue.dart';

class ChatData {
  final List<String> activeUser;
  final Map<String, ChatValue>? chats;

  ChatData({
    required this.activeUser,
    this.chats,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      activeUser: List<String>.from(json["activeUser"]!.map((x) => x)),
      chats: Map.from(json["chats"]!)
          .map((k, v) => MapEntry<String, ChatValue>(k, ChatValue.fromJson(v))),
    );
  }

  Map<String, dynamic> toJson() => {
        "activeUser": List<String>.from(activeUser.map((x) => x)),
        "chats": Map.from(chats!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class VendorChatData {
  final List<String> activeUser;
  final Map<String, VendorChat>? chats;

  VendorChatData({
    required this.activeUser,
    this.chats,
  });

  factory VendorChatData.fromJson(Map<String, dynamic> json) {
    return VendorChatData(
      activeUser: List<String>.from(json["activeUser"]!.map((x) => x)),
      chats: Map.from(json["chats"]!).map(
          (k, v) => MapEntry<String, VendorChat>(k, VendorChat.fromJson(v))),
    );
  }

  Map<String, dynamic> toJson() => {
        "activeUser": List<String>.from(activeUser.map((x) => x)),
        "chats": Map.from(chats!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}
