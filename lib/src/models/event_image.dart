// To parse this JSON data, do
//
//     final eventImage = eventImageFromJson(jsonString);

import 'dart:convert';

EventImage eventImageFromJson(String str) =>
    EventImage.fromJson(json.decode(str));

String eventImageToJson(EventImage data) => json.encode(data.toJson());

class EventImage {
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

  EventImage({
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

  factory EventImage.fromJson(Map<String, dynamic> json) => EventImage(
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
