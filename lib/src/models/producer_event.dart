// To parse this JSON data, do
//
//     final producerEvent = producerEventFromJson(jsonString);

import 'dart:convert';

ProducerEvent producerEventFromJson(String str) =>
    ProducerEvent.fromJson(json.decode(str));

String producerEventToJson(ProducerEvent data) => json.encode(data.toJson());

class ProducerEvent {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? location;
  final String? locationDetail;
  final String? referralCode;
  final String? userId;
  final List<String>? imageIds;
  final String? title;
  final List<String>? tags;
  final String? description;
  final String? timeType;
  final double? latitude;
  final double? longitude;
  final Latlong? latlong;
  final String? placeId;
  final List<Image>? image;
  final List<EventVendorCategoriesOnEvent>? eventVendorCategoriesOnEvent;

  ProducerEvent({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.startDate,
    this.endDate,
    this.location,
    this.locationDetail,
    this.referralCode,
    this.userId,
    this.imageIds,
    this.title,
    this.tags,
    this.description,
    this.timeType,
    this.latitude,
    this.longitude,
    this.latlong,
    this.placeId,
    this.image,
    this.eventVendorCategoriesOnEvent,
  });

  factory ProducerEvent.fromJson(Map<String, dynamic> json) => ProducerEvent(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        location: json["location"],
        locationDetail: json["locationDetail"],
        referralCode: json["referralCode"],
        userId: json["userId"],
        imageIds: json["imageIds"] == null
            ? []
            : List<String>.from(json["imageIds"]!.map((x) => x)),
        title: json["title"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        description: json["description"],
        timeType: json["timeType"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        latlong:
            json["latlong"] == null ? null : Latlong.fromJson(json["latlong"]),
        placeId: json["placeId"],
        image: json["image"] == null
            ? []
            : List<Image>.from(json["image"]!.map((x) => Image.fromJson(x))),
        eventVendorCategoriesOnEvent:
            json["EventVendorCategoriesOnEvent"] == null
                ? []
                : List<EventVendorCategoriesOnEvent>.from(
                    json["EventVendorCategoriesOnEvent"]!
                        .map((x) => EventVendorCategoriesOnEvent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "location": location,
        "locationDetail": locationDetail,
        "referralCode": referralCode,
        "userId": userId,
        "imageIds":
            imageIds == null ? [] : List<dynamic>.from(imageIds!.map((x) => x)),
        "title": title,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "description": description,
        "timeType": timeType,
        "latitude": latitude,
        "longitude": longitude,
        "latlong": latlong?.toJson(),
        "placeId": placeId,
        "image": image == null
            ? []
            : List<dynamic>.from(image!.map((x) => x.toJson())),
        "EventVendorCategoriesOnEvent": eventVendorCategoriesOnEvent == null
            ? []
            : List<dynamic>.from(
                eventVendorCategoriesOnEvent!.map((x) => x.toJson())),
      };
}

class EventVendorCategoriesOnEvent {
  final String? id;
  final String? eventId;
  final String? categoryId;
  final Category? category;

  EventVendorCategoriesOnEvent({
    this.id,
    this.eventId,
    this.categoryId,
    this.category,
  });

  factory EventVendorCategoriesOnEvent.fromJson(Map<String, dynamic> json) =>
      EventVendorCategoriesOnEvent(
        id: json["id"],
        eventId: json["eventId"],
        categoryId: json["categoryId"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "eventId": eventId,
        "categoryId": categoryId,
        "category": category?.toJson(),
      };
}

class Category {
  final String? title;
  final dynamic icon;

  Category({
    this.title,
    this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        title: json["title"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "icon": icon,
      };
}

class Image {
  final String? id;
  final DateTime? createdAt;
  final String? filename;
  final String? originalname;
  final int? size;
  final String? url;
  final String? type;
  final dynamic streamUrl;
  final dynamic thumbnail;
  final String? mediaType;
  final String? requestId;
  final List<dynamic>? eventId;

  Image({
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

  factory Image.fromJson(Map<String, dynamic> json) => Image(
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

class Latlong {
  final String? type;
  final List<double>? coordinate;

  Latlong({
    this.type,
    this.coordinate,
  });

  factory Latlong.fromJson(Map<String, dynamic> json) => Latlong(
        type: json["type"],
        coordinate: json["coordinate"] == null
            ? []
            : List<double>.from(json["coordinate"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinate": coordinate == null
            ? []
            : List<dynamic>.from(coordinate!.map((x) => x)),
      };
}
