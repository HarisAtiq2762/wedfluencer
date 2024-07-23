// To parse this JSON data, do
//
//     final chatValue = chatValueFromJson(jsonString);

import 'dart:convert';

ChatValue chatValueFromJson(String str) => ChatValue.fromJson(json.decode(str));

String chatValueToJson(ChatValue data) => json.encode(data.toJson());

class ChatValue {
  final List<Chatroom> chatrooms;
  final Proposal proposal;

  ChatValue({
    required this.chatrooms,
    required this.proposal,
  });

  factory ChatValue.fromJson(Map<String, dynamic> json) => ChatValue(
        chatrooms: List<Chatroom>.from(
            json["chatrooms"].map((x) => Chatroom.fromJson(x))),
        proposal: Proposal.fromJson(json["proposal"]),
      );

  Map<String, dynamic> toJson() => {
        "chatrooms": List<dynamic>.from(chatrooms.map((x) => x.toJson())),
        "proposal": proposal.toJson(),
      };
}

class Chatroom {
  final List<Chat> chat;
  final int unreadCount;
  final String contactUsername;
  final String contactUserId;
  final String contactFirstName;
  final String contactLastName;
  final String contactProfilePic;

  Chatroom({
    required this.chat,
    required this.unreadCount,
    required this.contactUsername,
    required this.contactUserId,
    required this.contactFirstName,
    required this.contactLastName,
    required this.contactProfilePic,
  });

  factory Chatroom.fromJson(Map<String, dynamic> json) => Chatroom(
        chat: List<Chat>.from(json["chat"].map((x) => Chat.fromJson(x))),
        unreadCount: json["unreadCount"] ?? 0,
        contactUsername: json["contactUsername"] ?? '',
        contactUserId: json["contactUserId"] ?? '',
        contactFirstName: json["contactFirstName"] ?? '',
        contactLastName: json["contactLastName"] ?? '',
        contactProfilePic: json["contactProfilePic"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "chat": List<dynamic>.from(chat.map((x) => x.toJson())),
        "unreadCount": unreadCount,
        "contactUsername": contactUsername,
        "contactUserId": contactUserId,
        "contactFirstName": contactFirstName,
        "contactLastName": contactLastName,
        "contactProfilePic": contactProfilePic,
      };
}

class Chat {
  final String id;
  final DateTime createdAt;
  final DateTime deletedAt;
  final String message;
  final String senderId;
  final String chatRoomId;
  final dynamic fileId;
  final bool seen;

  Chat({
    required this.id,
    required this.createdAt,
    required this.deletedAt,
    required this.message,
    required this.senderId,
    required this.chatRoomId,
    required this.fileId,
    required this.seen,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"] ?? '',
        createdAt: DateTime.parse(
            json["createdAt"] ?? DateTime.now().toIso8601String()),
        deletedAt: DateTime.parse(
            json["deletedAt"] ?? DateTime.now().toIso8601String()),
        message: json["message"] ?? '',
        senderId: json["senderId"] ?? '',
        chatRoomId: json["chatRoomId"] ?? '',
        fileId: json["fileId"] ?? '',
        seen: json["seen"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "deletedAt": deletedAt.toIso8601String(),
        "message": message,
        "senderId": senderId,
        "chatRoomId": chatRoomId,
        "fileId": fileId,
        "seen": seen,
      };
}

class Proposal {
  final String id;
  final String title;
  final List<Category> category;

  Proposal({
    required this.id,
    required this.title,
    required this.category,
  });

  factory Proposal.fromJson(Map<String, dynamic> json) => Proposal(
        id: json["id"],
        title: json["title"],
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
      };
}

class Category {
  final String title;

  Category({
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}
