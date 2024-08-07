// To parse this JSON data, do
//
//     final videoData = videoDataFromJson(jsonString);

import 'dart:convert';

VideoData videoDataFromJson(String str) => VideoData.fromJson(json.decode(str));

String videoDataToJson(VideoData data) => json.encode(data.toJson());

class VideoData {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? title;
  final int? order;
  final String? videoId;
  final List<String>? categoryIds;
  final List<dynamic>? tags;
  final String? description;
  final dynamic fee;
  final Video video;

  VideoData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.title,
    this.order,
    this.videoId,
    this.categoryIds,
    this.tags,
    this.description,
    this.fee,
    required this.video,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) => VideoData(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        title: json["title"],
        order: json["order"],
        videoId: json["videoId"],
        categoryIds: json["categoryIds"] == null
            ? []
            : List<String>.from(json["categoryIds"]!.map((x) => x)),
        tags: json["tags"] == null
            ? []
            : List<dynamic>.from(json["tags"]!.map((x) => x)),
        description: json["description"],
        fee: json["fee"],
        video: Video.fromJson(json["video"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "title": title,
        "order": order,
        "videoId": videoId,
        "categoryIds": categoryIds == null
            ? []
            : List<dynamic>.from(categoryIds!.map((x) => x)),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "description": description,
        "fee": fee,
        "video": video?.toJson(),
      };
}

class Video {
  final String? id;
  final DateTime? createdAt;
  final String? filename;
  final String? originalname;
  final int? size;
  final String url;
  final String? type;
  final String? streamUrl;
  final String? thumbnail;
  final String? mediaType;
  final String? requestId;
  final List<dynamic>? eventId;

  Video({
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

  factory Video.fromJson(Map<String, dynamic> json) => Video(
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
