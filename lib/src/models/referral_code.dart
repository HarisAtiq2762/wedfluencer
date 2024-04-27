// To parse this JSON data, do
//
//     final referralCode = referralCodeFromJson(jsonString);

import 'dart:convert';

ReferralCode referralCodeFromJson(String str) =>
    ReferralCode.fromJson(json.decode(str));

String referralCodeToJson(ReferralCode data) => json.encode(data.toJson());

class ReferralCode {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  DateTime? deletedAt;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final String locationDetail;
  final String referralCode;
  final String userId;
  final List<String> imageIds;
  final String title;
  final List<String> tags;
  final String description;
  final String timeType;
  final int latitude;
  final int longitude;
  final Latlong latlong;
  final String placeId;

  ReferralCode({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.locationDetail,
    required this.referralCode,
    required this.userId,
    required this.imageIds,
    required this.title,
    required this.tags,
    required this.description,
    required this.timeType,
    required this.latitude,
    required this.longitude,
    required this.latlong,
    required this.placeId,
  });

  factory ReferralCode.fromJson(Map<String, dynamic> json) => ReferralCode(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"] != null
            ? DateTime.parse(json["deletedAt"])
            : null,
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        location: json["location"],
        locationDetail: json["locationDetail"],
        referralCode: json["referralCode"],
        userId: json["userId"],
        imageIds: List<String>.from(json["imageIds"].map((x) => x)),
        title: json["title"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        description: json["description"],
        timeType: json["timeType"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        latlong: Latlong.fromJson(json["latlong"]),
        placeId: json["placeId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt!.toIso8601String(),
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "location": location,
        "locationDetail": locationDetail,
        "referralCode": referralCode,
        "userId": userId,
        "imageIds": List<dynamic>.from(imageIds.map((x) => x)),
        "title": title,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "description": description,
        "timeType": timeType,
        "latitude": latitude,
        "longitude": longitude,
        "latlong": latlong.toJson(),
        "placeId": placeId,
      };
}

class Latlong {
  final String type;
  final List<int> coordinate;

  Latlong({
    required this.type,
    required this.coordinate,
  });

  factory Latlong.fromJson(Map<String, dynamic> json) => Latlong(
        type: json["type"],
        coordinate: List<int>.from(json["coordinate"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinate": List<dynamic>.from(coordinate.map((x) => x)),
      };
}
