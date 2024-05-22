// To parse this JSON data, do
//
//     final chatMessageDetails = chatMessageDetailsFromJson(jsonString);

import 'dart:convert';

ChatMessageDetails chatMessageDetailsFromJson(String str) =>
    ChatMessageDetails.fromJson(json.decode(str));

String chatMessageDetailsToJson(ChatMessageDetails data) =>
    json.encode(data.toJson());

class ChatMessageDetails {
  final String id;
  final DateTime createdAt;
  final dynamic deletedAt;
  final String message;
  final String senderId;
  final String chatRoomId;
  final dynamic fileId;
  final bool seen;
  final Sender sender;
  final dynamic file;

  ChatMessageDetails({
    required this.id,
    required this.createdAt,
    required this.deletedAt,
    required this.message,
    required this.senderId,
    required this.chatRoomId,
    required this.fileId,
    required this.seen,
    required this.sender,
    required this.file,
  });

  factory ChatMessageDetails.fromJson(Map<String, dynamic> json) =>
      ChatMessageDetails(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        deletedAt: json["deletedAt"],
        message: json["message"] ?? "",
        senderId: json["senderId"],
        chatRoomId: json["chatRoomId"],
        fileId: json["fileId"],
        seen: json["seen"],
        sender: Sender.fromJson(json["sender"]),
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "deletedAt": deletedAt,
        "message": message,
        "senderId": senderId,
        "chatRoomId": chatRoomId,
        "fileId": fileId,
        "seen": seen,
        "sender": sender.toJson(),
        "file": file,
      };
}

class Sender {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String provider;
  final dynamic facebookId;
  final String username;
  final String firstname;
  final String lastname;
  final String roles;
  final String email;
  final String password;
  final String phonenumber;
  final String profilePicId;
  final dynamic weddingDetailId;
  final dynamic venderDetailId;
  final List<dynamic> chatRoomId;
  final String socialLinksId;
  final String bio;
  final String status;
  final int platformFee;
  final ProfilePic profilePic;

  Sender({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.provider,
    required this.facebookId,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.roles,
    required this.email,
    required this.password,
    required this.phonenumber,
    required this.profilePicId,
    required this.weddingDetailId,
    required this.venderDetailId,
    required this.chatRoomId,
    required this.socialLinksId,
    required this.bio,
    required this.status,
    required this.platformFee,
    required this.profilePic,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
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
        chatRoomId: List<dynamic>.from(json["chatRoomId"].map((x) => x)),
        socialLinksId: json["socialLinksId"],
        bio: json["bio"],
        status: json["status"],
        platformFee: json["platformFee"],
        profilePic: ProfilePic.fromJson(json["profilePic"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
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
        "chatRoomId": List<dynamic>.from(chatRoomId.map((x) => x)),
        "socialLinksId": socialLinksId,
        "bio": bio,
        "status": status,
        "platformFee": platformFee,
        "profilePic": profilePic.toJson(),
      };
}

class ProfilePic {
  final String id;
  final DateTime createdAt;
  final String filename;
  final String originalname;
  final int size;
  final String url;
  final String type;
  final dynamic streamUrl;
  final dynamic thumbnail;
  final String mediaType;
  final String requestId;
  final List<dynamic> eventId;

  ProfilePic({
    required this.id,
    required this.createdAt,
    required this.filename,
    required this.originalname,
    required this.size,
    required this.url,
    required this.type,
    required this.streamUrl,
    required this.thumbnail,
    required this.mediaType,
    required this.requestId,
    required this.eventId,
  });

  factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        filename: json["filename"],
        originalname: json["originalname"],
        size: json["size"],
        url: json["url"],
        type: json["type"],
        streamUrl: json["streamUrl"],
        thumbnail: json["thumbnail"],
        mediaType: json["mediaType"],
        requestId: json["requestId"],
        eventId: List<dynamic>.from(json["eventId"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "filename": filename,
        "originalname": originalname,
        "size": size,
        "url": url,
        "type": type,
        "streamUrl": streamUrl,
        "thumbnail": thumbnail,
        "mediaType": mediaType,
        "requestId": requestId,
        "eventId": List<dynamic>.from(eventId.map((x) => x)),
      };
}
