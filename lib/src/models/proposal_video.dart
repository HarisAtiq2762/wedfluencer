// To parse this JSON data, do
//
//     final proposalVideo = proposalVideoFromJson(jsonString);

import 'dart:convert';

ProposalVideo proposalVideoFromJson(String str) =>
    ProposalVideo.fromJson(json.decode(str));

String proposalVideoToJson(ProposalVideo data) => json.encode(data.toJson());

class ProposalVideo {
  String? title;
  String? id;
  DateTime? createdAt;
  String? userId;
  String? eventId;
  String? status;
  List<dynamic>? keywords;
  List<dynamic>? brands;
  List<dynamic>? labels;
  List<dynamic>? topics;
  dynamic allowVendors;
  int? price;
  FileClass? file;
  List<dynamic>? chatRoom;
  List<Category>? category;
  User? user;
  Count? count;

  ProposalVideo({
    this.title,
    this.id,
    this.createdAt,
    this.userId,
    this.eventId,
    this.status,
    this.keywords,
    this.brands,
    this.labels,
    this.topics,
    this.allowVendors,
    this.price,
    this.file,
    this.chatRoom,
    this.category,
    this.user,
    this.count,
  });

  factory ProposalVideo.fromJson(Map<String, dynamic> json) => ProposalVideo(
        title: json["title"],
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        userId: json["userId"],
        eventId: json["eventId"],
        status: json["status"],
        keywords: json["keywords"] == null
            ? []
            : List<dynamic>.from(json["keywords"]!.map((x) => x)),
        brands: json["brands"] == null
            ? []
            : List<dynamic>.from(json["brands"]!.map((x) => x)),
        labels: json["labels"] == null
            ? []
            : List<dynamic>.from(json["labels"]!.map((x) => x)),
        topics: json["topics"] == null
            ? []
            : List<dynamic>.from(json["topics"]!.map((x) => x)),
        allowVendors: json["allowVendors"],
        price: json["price"],
        file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
        chatRoom: json["ChatRoom"] == null
            ? []
            : List<dynamic>.from(json["ChatRoom"]!.map((x) => x)),
        category: json["category"] == null
            ? []
            : List<Category>.from(
                json["category"]!.map((x) => Category.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "userId": userId,
        "eventId": eventId,
        "status": status,
        "keywords":
            keywords == null ? [] : List<dynamic>.from(keywords!.map((x) => x)),
        "brands":
            brands == null ? [] : List<dynamic>.from(brands!.map((x) => x)),
        "labels":
            labels == null ? [] : List<dynamic>.from(labels!.map((x) => x)),
        "topics":
            topics == null ? [] : List<dynamic>.from(topics!.map((x) => x)),
        "allowVendors": allowVendors,
        "price": price,
        "file": file?.toJson(),
        "ChatRoom":
            chatRoom == null ? [] : List<dynamic>.from(chatRoom!.map((x) => x)),
        "category": category == null
            ? []
            : List<dynamic>.from(category!.map((x) => x.toJson())),
        "user": user?.toJson(),
        "_count": count?.toJson(),
      };
}

class Category {
  String? id;
  String? title;

  Category({
    this.id,
    this.title,
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

class Count {
  int? category;
  int? chatRoom;
  int? payments;

  Count({
    this.category,
    this.chatRoom,
    this.payments,
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
  String? id;
  DateTime? createdAt;
  String? filename;
  String? originalname;
  int? size;
  String? url;
  String? type;
  String? streamUrl;
  String? thumbnail;
  String? mediaType;
  String? requestId;
  List<dynamic>? eventId;

  FileClass({
    this.id,
    this.createdAt,
    this.filename,
    this.originalname,
    this.size,
    this.url,
    this.type,
    this.streamUrl,
    this.thumbnail,
    this.mediaType,
    this.requestId,
    this.eventId,
  });

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        filename: json["filename"],
        originalname: json["originalname"],
        size: json["size"],
        url: json["url"],
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

class User {
  String? id;
  String? username;
  String? firstname;
  String? lastname;
  String? email;
  String? phonenumber;
  WeddingDetail? weddingDetail;

  User({
    this.id,
    this.username,
    this.firstname,
    this.lastname,
    this.email,
    this.phonenumber,
    this.weddingDetail,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        phonenumber: json["phonenumber"],
        weddingDetail: json["weddingDetail"] == null
            ? null
            : WeddingDetail.fromJson(json["weddingDetail"]),
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
  String? city;
  dynamic location;
  DateTime? date;

  WeddingDetail({
    this.city,
    this.location,
    this.date,
  });

  factory WeddingDetail.fromJson(Map<String, dynamic> json) => WeddingDetail(
        city: json["city"],
        location: json["location"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "location": location,
        "date": date?.toIso8601String(),
      };
}
