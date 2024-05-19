// To parse this JSON data, do
//
//     final proposalVideo = proposalVideoFromJson(jsonString);

import 'dart:convert';

ProposalVideo proposalVideoFromJson(String str) =>
    ProposalVideo.fromJson(json.decode(str));

String proposalVideoToJson(ProposalVideo data) => json.encode(data.toJson());

class ProposalVideo {
  final String title;
  final String id;
  final DateTime createdAt;
  final String userId;
  final String eventId;
  final String status;
  final List<String> keywords;
  final List<dynamic> brands;
  final List<String> labels;
  final List<String> topics;
  final int? allowVendors;
  final int price;
  final FileClass file;
  final List<ChatRoom> chatRoom;
  final List<Category> category;
  final User user;
  final Count count;
  final bool hasPaid;

  ProposalVideo({
    required this.title,
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.eventId,
    required this.status,
    required this.keywords,
    required this.brands,
    required this.labels,
    required this.topics,
    required this.allowVendors,
    required this.price,
    required this.file,
    required this.chatRoom,
    required this.category,
    required this.user,
    required this.count,
    required this.hasPaid,
  });

  factory ProposalVideo.fromJson(Map<String, dynamic> json) {
    return ProposalVideo(
      title: json["title"] ?? "",
      id: json["id"] ?? "",
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : DateTime.now(),
      userId: json["userId"] ?? "",
      eventId: json["eventId"] ?? "",
      status: json["status"] ?? "",
      keywords: List<String>.from(json["keywords"].map((x) => x)),
      brands: List<dynamic>.from(json["brands"].map((x) => x)),
      labels: List<String>.from(json["labels"].map((x) => x)),
      topics: List<String>.from(json["topics"].map((x) => x)),
      allowVendors: json["allowVendors"] ?? 0,
      price: json["price"] ?? 0,
      file: FileClass.fromJson(json["file"]),
      chatRoom: List<ChatRoom>.from(
          json["ChatRoom"].map((x) => ChatRoom.fromJson(x))),
      category: List<Category>.from(
          json["category"].map((x) => Category.fromJson(x))),
      user: User.fromJson(json["user"]),
      count: json["_count"] != null
          ? Count.fromJson(json["_count"])
          : Count(category: 0, chatRoom: 0, payments: 0),
      hasPaid: json["hasPaid"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "userId": userId,
        "eventId": eventId,
        "status": status,
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
        "brands": List<dynamic>.from(brands.map((x) => x)),
        "labels": List<dynamic>.from(labels.map((x) => x)),
        "topics": List<dynamic>.from(topics.map((x) => x)),
        "allowVendors": allowVendors,
        "price": price,
        "file": file.toJson(),
        "ChatRoom": List<dynamic>.from(chatRoom.map((x) => x.toJson())),
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "user": user.toJson(),
        "_count": count.toJson(),
        "hasPaid": hasPaid,
      };
}

class Category {
  final String id;
  final String title;

  Category({
    required this.id,
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

class ChatRoom {
  final String id;

  ChatRoom({
    required this.id,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Count {
  final int category;
  final int chatRoom;
  final int payments;

  Count({
    required this.category,
    required this.chatRoom,
    required this.payments,
  });

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        category: json["category"],
        chatRoom: json["ChatRoom"],
        payments: json["payments"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "ChatRoom": chatRoom,
        "payments": payments,
      };
}

class FileClass {
  final String id;
  final DateTime createdAt;
  final String filename;
  final String originalname;
  final int size;
  final String url;
  final String type;
  final String streamUrl;
  final String thumbnail;
  final String mediaType;
  final String requestId;
  final List<dynamic> eventId;

  FileClass({
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

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
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

class User {
  final String id;
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String phonenumber;
  final WeddingDetail? weddingDetail;

  User({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phonenumber,
    this.weddingDetail,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        phonenumber: json["phonenumber"],
        weddingDetail: json["weddingDetail"] != null
            ? WeddingDetail.fromJson(json["weddingDetail"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "phonenumber": phonenumber,
        "weddingDetail": weddingDetail?.toJson(),
      };
}

class WeddingDetail {
  final String city;
  final dynamic location;
  final DateTime date;

  WeddingDetail({
    required this.city,
    this.location,
    required this.date,
  });

  factory WeddingDetail.fromJson(Map<String, dynamic> json) => WeddingDetail(
        city: json["city"],
        location: json["location"] ?? json["location"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "location": location,
        "date": date.toIso8601String(),
      };
}
