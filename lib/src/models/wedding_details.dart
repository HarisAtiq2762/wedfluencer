class WeddingDetails {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  DateTime date;
  final String? location;
  final GeoLocation geoLocation;
  final String? referralCode;
  final String? eventId;
  String city;
  String type;
  int noOfGuests;

  WeddingDetails({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.date,
    this.location,
    required this.geoLocation,
    this.referralCode,
    this.eventId,
    required this.city,
    required this.type,
    required this.noOfGuests,
  });

  factory WeddingDetails.fromJson(Map<String, dynamic> json) => WeddingDetails(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"] != null
            ? DateTime.parse(json["deletedAt"])
            : null,
        date: DateTime.parse(json["date"]),
        location: json["location"],
        geoLocation: GeoLocation.fromJson(json["geoLocation"]),
        referralCode: json["referralCode"],
        eventId: json["eventId"],
        city: json["city"],
        type: json["type"],
        noOfGuests: json["noOfGuests"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt?.toIso8601String(),
        "date": date.toIso8601String(),
        "location": location,
        "geoLocation": geoLocation.toJson(),
        "referralCode": referralCode,
        "eventId": eventId,
        "city": city,
        "type": type,
        "noOfGuests": noOfGuests,
      };
}

class GeoLocation {
  final double lat;
  final double lng;

  GeoLocation({
    required this.lat,
    required this.lng,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) => GeoLocation(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
