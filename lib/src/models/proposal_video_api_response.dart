// To parse this JSON data, do
//
//     final proposalVideoApiResponse = proposalVideoApiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:wedfluencer/src/models/proposal_video.dart';

ProposalVideoApiResponse proposalVideoApiResponseFromJson(String str) =>
    ProposalVideoApiResponse.fromJson(json.decode(str));

String proposalVideoApiResponseToJson(ProposalVideoApiResponse data) =>
    json.encode(data.toJson());

class ProposalVideoApiResponse {
  Data? data;
  int? totalCount;
  int? take;
  int? currentPage;
  int? totalPages;
  int? remainingPages;

  ProposalVideoApiResponse({
    this.data,
    this.totalCount,
    this.take,
    this.currentPage,
    this.totalPages,
    this.remainingPages,
  });

  factory ProposalVideoApiResponse.fromJson(Map<String, dynamic> json) =>
      ProposalVideoApiResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        totalCount: json["totalCount"],
        take: json["take"],
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        remainingPages: json["remainingPages"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "totalCount": totalCount,
        "take": take,
        "currentPage": currentPage,
        "totalPages": totalPages,
        "remainingPages": remainingPages,
      };
}

class Data {
  List<ProposalVideo>? proposalVideos;
  int? total;
  int? approved;
  int? declined;
  int? disabled;
  int? removed;
  int? failed;

  Data({
    this.proposalVideos,
    this.total,
    this.approved,
    this.declined,
    this.disabled,
    this.removed,
    this.failed,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        proposalVideos: json["proposalVideos"] == null
            ? []
            : List<ProposalVideo>.from(
                json["proposalVideos"]!.map((x) => ProposalVideo.fromJson(x))),
        total: json["total"],
        approved: json["approved"],
        declined: json["declined"],
        disabled: json["disabled"],
        removed: json["removed"],
        failed: json["failed"],
      );

  Map<String, dynamic> toJson() => {
        "proposalVideos": proposalVideos == null
            ? []
            : List<dynamic>.from(proposalVideos!.map((x) => x.toJson())),
        "total": total,
        "approved": approved,
        "declined": declined,
        "disabled": disabled,
        "removed": removed,
        "failed": failed,
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

enum EventId {
  THE_65_D207_DF0_C40698_ED4_A7_CD19,
  THE_661_CF0_FA55_D6_EED3729_D5_C2_E
}

final eventIdValues = EnumValues({
  "65d207df0c40698ed4a7cd19": EventId.THE_65_D207_DF0_C40698_ED4_A7_CD19,
  "661cf0fa55d6eed3729d5c2e": EventId.THE_661_CF0_FA55_D6_EED3729_D5_C2_E
});

class FileClass {
  String? id;
  DateTime? createdAt;
  String? filename;
  String? originalname;
  int? size;
  String? url;
  Type? type;
  String? streamUrl;
  String? thumbnail;
  MediaType? mediaType;
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
        type: typeValues.map[json["type"]]!,
        streamUrl: json["streamUrl"],
        thumbnail: json["thumbnail"],
        mediaType: mediaTypeValues.map[json["mediaType"]]!,
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
        "type": typeValues.reverse[type],
        "streamUrl": streamUrl,
        "thumbnail": thumbnail,
        "mediaType": mediaTypeValues.reverse[mediaType],
        "requestId": requestId,
        "eventId":
            eventId == null ? [] : List<dynamic>.from(eventId!.map((x) => x)),
      };
}

enum MediaType { IMAGE }

final mediaTypeValues = EnumValues({"Image": MediaType.IMAGE});

enum Type { APPLICATION_OCTET_STREAM }

final typeValues =
    EnumValues({"application/octet-stream": Type.APPLICATION_OCTET_STREAM});

enum Status { IN_REVIEW }

final statusValues = EnumValues({"InReview": Status.IN_REVIEW});

class User {
  UserId? id;
  Username? username;
  Firstname? firstname;
  Lastname? lastname;
  Email? email;
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
        id: userIdValues.map[json["id"]]!,
        username: usernameValues.map[json["username"]]!,
        firstname: firstnameValues.map[json["firstname"]]!,
        lastname: lastnameValues.map[json["lastname"]]!,
        email: emailValues.map[json["email"]]!,
        phonenumber: json["phonenumber"],
        weddingDetail: json["weddingDetail"] == null
            ? null
            : WeddingDetail.fromJson(json["weddingDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": userIdValues.reverse[id],
        "username": usernameValues.reverse[username],
        "firstname": firstnameValues.reverse[firstname],
        "lastname": lastnameValues.reverse[lastname],
        "email": emailValues.reverse[email],
        "phonenumber": phonenumber,
        "weddingDetail": weddingDetail?.toJson(),
      };
}

enum Email { GROOM_GMAIL_COM }

final emailValues = EnumValues({"groom@gmail.com": Email.GROOM_GMAIL_COM});

enum Firstname { GROOM_F }

final firstnameValues = EnumValues({"groom F": Firstname.GROOM_F});

enum UserId { THE_65_F194144694_B32_E130006_DB }

final userIdValues = EnumValues(
    {"65f194144694b32e130006db": UserId.THE_65_F194144694_B32_E130006_DB});

enum Lastname { GROOM_L }

final lastnameValues = EnumValues({"groom L": Lastname.GROOM_L});

enum Username { GROOM }

final usernameValues = EnumValues({"groom": Username.GROOM});

class WeddingDetail {
  City? city;
  dynamic location;
  DateTime? date;

  WeddingDetail({
    this.city,
    this.location,
    this.date,
  });

  factory WeddingDetail.fromJson(Map<String, dynamic> json) => WeddingDetail(
        city: cityValues.map[json["city"]]!,
        location: json["location"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "city": cityValues.reverse[city],
        "location": location,
        "date": date?.toIso8601String(),
      };
}

enum City { MULHOUSE_FRANCE }

final cityValues = EnumValues({"Mulhouse, France": City.MULHOUSE_FRANCE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
