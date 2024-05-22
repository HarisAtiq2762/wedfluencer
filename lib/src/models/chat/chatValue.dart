class ChatValue {
  final String? contactUsername;
  final String? contactUserId;
  final List<Chatroom>? chatrooms;
  final List<ChatUser>? users;
  final int? totalUnreadCount;

  ChatValue({
    this.contactUsername,
    this.contactUserId,
    this.chatrooms,
    this.users,
    this.totalUnreadCount,
  });

  factory ChatValue.fromJson(Map<String, dynamic> json) => ChatValue(
        contactUsername: json["contactUsername"],
        contactUserId: json["contactUserId"],
        chatrooms: json["chatrooms"] == null
            ? []
            : List<Chatroom>.from(
                json["chatrooms"]!.map((x) => Chatroom.fromJson(x))),
        users: json["users"] == null
            ? []
            : List<ChatUser>.from(
                json["users"]!.map((x) => ChatUser.fromJson(x))),
        totalUnreadCount: json["totalUnreadCount"],
      );

  Map<String, dynamic> toJson() => {
        "contactUsername": contactUsername,
        "contactUserId": contactUserId,
        "chatrooms": chatrooms == null
            ? []
            : List<dynamic>.from(chatrooms!.map((x) => x.toJson())),
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
        "totalUnreadCount": totalUnreadCount,
      };
}

class Chatroom {
  final List<ChatElement>? chat;
  final Proposal? proposal;
  final int? unreadCount;

  Chatroom({
    this.chat,
    this.proposal,
    this.unreadCount,
  });

  factory Chatroom.fromJson(Map<String, dynamic> json) => Chatroom(
        chat: json["chat"] == null
            ? []
            : List<ChatElement>.from(
                json["chat"]!.map((x) => ChatElement.fromJson(x))),
        proposal: json["proposal"] == null
            ? null
            : Proposal.fromJson(json["proposal"]),
        unreadCount: json["unreadCount"],
      );

  Map<String, dynamic> toJson() => {
        "chat": chat == null
            ? []
            : List<dynamic>.from(chat!.map((x) => x.toJson())),
        "proposal": proposal?.toJson(),
        "unreadCount": unreadCount,
      };
}

class ChatElement {
  final String? id;
  final DateTime createdAt;
  final dynamic deletedAt;
  final String message;
  final String? senderId;
  final String? chatRoomId;
  final dynamic fileId;
  final bool? seen;

  ChatElement({
    this.id,
    required this.createdAt,
    this.deletedAt,
    required this.message,
    this.senderId,
    this.chatRoomId,
    this.fileId,
    this.seen,
  });

  factory ChatElement.fromJson(Map<String, dynamic> json) => ChatElement(
        id: json["id"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        deletedAt: json["deletedAt"],
        message: json["message"] ?? " ",
        senderId: json["senderId"],
        chatRoomId: json["chatRoomId"],
        fileId: json["fileId"],
        seen: json["seen"],
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
  final List<ChatCategory>? category;

  Proposal({
    required this.id,
    required this.title,
    this.category,
  });

  factory Proposal.fromJson(Map<String, dynamic> json) => Proposal(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        category: json["category"] == null
            ? []
            : List<ChatCategory>.from(
                json["category"]!.map((x) => ChatCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "category": category == null
            ? []
            : List<dynamic>.from(category!.map((x) => x.toJson())),
      };
}

class ChatCategory {
  final String? title;

  ChatCategory({
    this.title,
  });

  factory ChatCategory.fromJson(Map<String, dynamic> json) => ChatCategory(
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}

class ChatUser {
  final String id;
  final String username;
  final String firstname;
  final String lastname;
  final ProfilePic profilePic;
  final VendorDetail vendorDetail;

  ChatUser({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.profilePic,
    required this.vendorDetail,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        id: json["id"],
        username: json["username"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        profilePic: json["profilePic"] == null
            ? ProfilePic(url: '')
            : ProfilePic.fromJson(json["profilePic"]),
        vendorDetail: json["venderDetail"] == null
            ? VendorDetail()
            : VendorDetail.fromJson(json["venderDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "profilePic": profilePic.toJson(),
        "venderDetail": vendorDetail.toJson(),
      };
}

class ProfilePic {
  final String? id;
  final DateTime? createdAt;
  final String? filename;
  final String? originalname;
  final int? size;
  final String url;
  final String? type;
  final dynamic streamUrl;
  final dynamic thumbnail;
  final String? mediaType;
  final String? requestId;
  final List<dynamic>? eventId;

  ProfilePic({
    this.id,
    this.createdAt,
    this.filename,
    this.originalname,
    this.size,
    required this.url,
    this.type,
    this.streamUrl,
    this.thumbnail,
    this.mediaType,
    this.requestId,
    this.eventId,
  });

  factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        filename: json["filename"],
        originalname: json["originalname"],
        size: json["size"],
        url: json["url"] ?? "",
        type: json["type"],
        streamUrl: json["streamUrl"],
        thumbnail: json["thumbnail"],
        mediaType: json["mediaType"],
        requestId: json["requestId"],
        eventId: json["eventId"] == null
            ? []
            : List<dynamic>.from(json["eventId"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "filename": filename,
        "originalname": originalname,
        "size": size,
        "url": url,
        "type": type,
        "streamUrl": streamUrl,
        "thumbnail": thumbnail,
        "mediaType": mediaType,
        "requestId": requestId,
        "eventId":
            eventId == null ? [] : List<dynamic>.from(eventId!.map((x) => x)),
      };
}

class VendorDetail {
  final List<ChatCategory>? category;

  VendorDetail({
    this.category,
  });

  factory VendorDetail.fromJson(Map<String, dynamic> json) => VendorDetail(
        category: json["Categroy"] == null
            ? []
            : List<ChatCategory>.from(
                json["Categroy"]!.map((x) => ChatCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Categroy": category == null
            ? []
            : List<dynamic>.from(category!.map((x) => x.toJson())),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
