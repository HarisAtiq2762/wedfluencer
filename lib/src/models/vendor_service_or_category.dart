// To parse this JSON data, do
//
//     final vendorService = vendorServiceFromJson(jsonString);

import 'dart:convert';

VendorServiceOrCategory vendorServiceOrCategoryFromJson(String str) =>
    VendorServiceOrCategory.fromJson(json.decode(str));

String vendorServiceOrCategoryToJson(VendorServiceOrCategory data) =>
    json.encode(data.toJson());

class VendorServiceOrCategory {
  final String id;
  final String title;
  final DateTime createdAt;
  final List<String> types;
  final int fee;
  final Icon? icon;

  VendorServiceOrCategory({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.types,
    required this.fee,
    this.icon,
  });

  factory VendorServiceOrCategory.fromJson(Map<String, dynamic> json) =>
      VendorServiceOrCategory(
        id: json["id"],
        title: json["title"],
        createdAt: DateTime.parse(json["createdAt"]),
        types: List<String>.from(json["types"].map((x) => x)),
        fee: json["fee"],
        icon: json["icon"] != null ? Icon.fromJson(json["icon"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "createdAt": createdAt.toIso8601String(),
        "types": List<dynamic>.from(types.map((x) => x)),
        "fee": fee,
        "icon": icon?.toJson(),
      };
}

class Icon {
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

  Icon({
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

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
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
