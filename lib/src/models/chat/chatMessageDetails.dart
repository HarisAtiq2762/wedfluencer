// To parse this JSON data, do
//
//     final chatMessageDetails = chatMessageDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:wedfluencer/src/models/wedfluencer_file.dart';

ChatMessageDetails chatMessageDetailsFromJson(String str) =>
    ChatMessageDetails.fromJson(json.decode(str));

String chatMessageDetailsToJson(ChatMessageDetails data) =>
    json.encode(data.toJson());

class ChatMessageDetails {
  final String? id;
  final DateTime? createdAt;
  final dynamic deletedAt;
  final String? message;
  final String? senderId;
  final String? chatRoomId;
  final dynamic fileId;
  final bool? seen;
  final Sender? sender;
  final WedfluencerFile? file;

  ChatMessageDetails({
    this.id,
    this.createdAt,
    this.deletedAt,
    this.message,
    this.senderId,
    this.chatRoomId,
    this.fileId,
    this.seen,
    this.sender,
    this.file,
  });

  factory ChatMessageDetails.fromJson(Map<String, dynamic> json) =>
      ChatMessageDetails(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deletedAt: json["deletedAt"],
        message: json["message"],
        senderId: json["senderId"],
        chatRoomId: json["chatRoomId"],
        fileId: json["fileId"],
        seen: json["seen"],
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
        file: json["file"] != null
            ? WedfluencerFile.fromJson(json["file"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "message": message,
        "senderId": senderId,
        "chatRoomId": chatRoomId,
        "fileId": fileId,
        "seen": seen,
        "sender": sender?.toJson(),
        "file": file,
      };
}

class Sender {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? provider;
  final dynamic facebookId;
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? roles;
  final String? email;
  final String? password;
  final String? phonenumber;
  final dynamic profilePicId;
  final dynamic weddingDetailId;
  final String? venderDetailId;
  final List<dynamic>? chatRoomId;
  final String? socialLinksId;
  final String? bio;
  final String? status;
  final int? platformFee;
  final dynamic followersCount;
  final dynamic followingCount;
  final dynamic profilePic;

  Sender({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.provider,
    this.facebookId,
    this.username,
    this.firstname,
    this.lastname,
    this.roles,
    this.email,
    this.password,
    this.phonenumber,
    this.profilePicId,
    this.weddingDetailId,
    this.venderDetailId,
    this.chatRoomId,
    this.socialLinksId,
    this.bio,
    this.status,
    this.platformFee,
    this.followersCount,
    this.followingCount,
    this.profilePic,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        provider: json["provider"],
        facebookId: json["facebookId"],
        username: json["username"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        roles: json["roles"],
        email: json["email"],
        password: json["password"],
        phonenumber: json["phonenumber"],
        profilePicId: json["profilePicId"],
        weddingDetailId: json["weddingDetailId"],
        venderDetailId: json["venderDetailId"],
        chatRoomId: json["chatRoomId"] == null
            ? []
            : List<dynamic>.from(json["chatRoomId"]!.map((x) => x)),
        socialLinksId: json["socialLinksId"],
        bio: json["bio"],
        status: json["status"],
        platformFee: json["platformFee"],
        followersCount: json["followersCount"],
        followingCount: json["followingCount"],
        profilePic: json["profilePic"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "provider": provider,
        "facebookId": facebookId,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "roles": roles,
        "email": email,
        "password": password,
        "phonenumber": phonenumber,
        "profilePicId": profilePicId,
        "weddingDetailId": weddingDetailId,
        "venderDetailId": venderDetailId,
        "chatRoomId": chatRoomId == null
            ? []
            : List<dynamic>.from(chatRoomId!.map((x) => x)),
        "socialLinksId": socialLinksId,
        "bio": bio,
        "status": status,
        "platformFee": platformFee,
        "followersCount": followersCount,
        "followingCount": followingCount,
        "profilePic": profilePic,
      };
}
