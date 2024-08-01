class VendorChat {
  final String contactUsername;
  final String contactUserId;
  final List<Chatroom> chatrooms;
  final List<User> users;
  final int totalUnreadCount;

  VendorChat({
    required this.contactUsername,
    required this.contactUserId,
    required this.chatrooms,
    required this.users,
    required this.totalUnreadCount,
  });

  factory VendorChat.fromJson(Map<String, dynamic> json) {
    return VendorChat(
      contactUsername: json["contactUsername"] ?? '',
      contactUserId: json["contactUserId"] ?? '',
      chatrooms: List<Chatroom>.from(
          json["chatrooms"].map((x) => Chatroom.fromJson(x))),
      users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      totalUnreadCount: json["totalUnreadCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "contactUsername": contactUsername,
        "contactUserId": contactUserId,
        "chatrooms": List<dynamic>.from(chatrooms.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "totalUnreadCount": totalUnreadCount,
      };
}

class Chatroom {
  final List<Chat> chat;
  final Proposal proposal;
  final int unreadCount;

  Chatroom({
    required this.chat,
    required this.proposal,
    required this.unreadCount,
  });

  factory Chatroom.fromJson(Map<String, dynamic> json) {
    return Chatroom(
      chat: List<Chat>.from(json["chat"].map((x) => Chat.fromJson(x))),
      proposal: json["proposal"] != null
          ? Proposal.fromJson(json["proposal"])
          : Proposal(id: '', title: '', category: []),
      unreadCount: json["unreadCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "chat": List<dynamic>.from(chat.map((x) => x.toJson())),
        "proposal": proposal.toJson(),
        "unreadCount": unreadCount,
      };
}

class Chat {
  final String id;
  final DateTime createdAt;
  final dynamic deletedAt;
  final String message;
  final String senderId;
  final String chatRoomId;
  final String fileId;
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
        deletedAt: json["deletedAt"] ?? "",
        message: json["message"] ?? "",
        senderId: json["senderId"] ?? "",
        chatRoomId: json["chatRoomId"] ?? "",
        fileId: json["fileId"] ?? "",
        seen: json["seen"] ?? false,
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
        id: json["id"] ?? "",
        title: json["title"] ?? "",
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
        title: json["title"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}

class User {
  final String id;
  final String username;
  final String firstname;
  final String lastname;
  final ProfilePic profilePic;
  final dynamic venderDetail;

  User({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.profilePic,
    required this.venderDetail,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? "",
        username: json["username"] ?? "",
        firstname: json["firstname"] ?? "",
        lastname: json["lastname"] ?? "",
        profilePic: json["profilePic"] != null
            ? ProfilePic.fromJson(json["profilePic"])
            : ProfilePic(
                id: '',
                createdAt: DateTime.now(),
                filename: '',
                originalname: '',
                size: 0,
                url: '',
                type: '',
                streamUrl: '',
                videoId: '',
                thumbnail: '',
                mediaType: '',
                eventId: []),
        venderDetail: json["venderDetail"] ?? {},
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "profilePic": profilePic?.toJson(),
        "venderDetail": venderDetail,
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
  final dynamic videoId;
  final dynamic thumbnail;
  final String mediaType;
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
    required this.videoId,
    required this.thumbnail,
    required this.mediaType,
    required this.eventId,
  });

  factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
        id: json["id"] ?? "",
        createdAt: DateTime.parse(
            json["createdAt"] ?? DateTime.now().toIso8601String()),
        filename: json["filename"] ?? "",
        originalname: json["originalname"] ?? "",
        size: json["size"] ?? 0,
        url: json["url"] ?? "",
        type: json["type"] ?? "",
        streamUrl: json["streamUrl"] ?? "",
        videoId: json["videoId"] ?? "",
        thumbnail: json["thumbnail"] ?? "",
        mediaType: json["mediaType"] ?? "",
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
        "videoId": videoId,
        "thumbnail": thumbnail,
        "mediaType": mediaType,
        "eventId": List<dynamic>.from(eventId.map((x) => x)),
      };
}
