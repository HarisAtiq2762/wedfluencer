import 'dart:convert';

import 'package:flutter/material.dart';

import '../infrastructure/domain/authentication/models/user_model.dart';

class User {
  String email;
  String password;
  bool isInWeddingBusiness;
  bool isGettingMarried;
  String firstName;
  String lastName;
  String userName;
  String phoneNumber;
  Image? image;
  UserRole role;

  User(
      {required this.email,
      required this.password,
      required this.isInWeddingBusiness,
      required this.isGettingMarried,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.phoneNumber,
      required this.role,
      this.image});

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "image": image,
        "userName": userName,
        "email": email,
        "password": password,
        "isInWeddingBusiness": isInWeddingBusiness,
        "isGettingMarried": isGettingMarried,
        "phoneNumber": phoneNumber,
        "role": role,
      };
}

// To parse this JSON data, do
//
//     final wedfluencerUser = wedfluencerUserFromJson(jsonString);

WedfluencerUser wedfluencerUserFromJson(String str) =>
    WedfluencerUser.fromJson(json.decode(str));

String wedfluencerUserToJson(WedfluencerUser data) =>
    json.encode(data.toJson());

class WedfluencerUser {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? provider;
  final dynamic facebookId;
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? roles;
  final String? email;
  final String? password;
  final String? phonenumber;
  final dynamic profilePicId;
  final String? weddingDetailId;
  final dynamic venderDetailId;
  final List<dynamic>? chatRoomId;
  final dynamic socialLinksId;
  final dynamic bio;
  final String? status;
  final dynamic platformFee;
  final WeddingDetail? weddingDetail;
  final dynamic profilePic;
  String? accessToken;
  String? refreshToken;

  WedfluencerUser({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.provider,
    this.facebookId,
    this.username,
    this.firstname,
    this.lastname,
    this.roles,
    this.email,
    this.password,
    this.phonenumber,
    this.profilePicId,
    this.weddingDetailId,
    this.venderDetailId,
    this.chatRoomId,
    this.socialLinksId,
    this.bio,
    this.status,
    this.platformFee,
    this.weddingDetail,
    this.profilePic,
    this.accessToken,
    this.refreshToken,
  });

  factory WedfluencerUser.fromJson(Map<String, dynamic> json) =>
      WedfluencerUser(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        provider: json["provider"],
        facebookId: json["facebookId"],
        username: json["username"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        roles: json["roles"],
        email: json["email"],
        password: json["password"],
        phonenumber: json["phonenumber"],
        profilePicId: json["profilePicId"],
        weddingDetailId: json["weddingDetailId"],
        venderDetailId: json["venderDetailId"],
        chatRoomId: json["chatRoomId"] == null
            ? []
            : List<dynamic>.from(json["chatRoomId"]!.map((x) => x)),
        socialLinksId: json["socialLinksId"],
        bio: json["bio"],
        status: json["status"],
        platformFee: json["platformFee"],
        weddingDetail: json["weddingDetail"] == null
            ? null
            : WeddingDetail.fromJson(json["weddingDetail"]),
        profilePic: json["profilePic"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "provider": provider,
        "facebookId": facebookId,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "roles": roles,
        "email": email,
        "password": password,
        "phonenumber": phonenumber,
        "profilePicId": profilePicId,
        "weddingDetailId": weddingDetailId,
        "venderDetailId": venderDetailId,
        "chatRoomId": chatRoomId == null
            ? []
            : List<dynamic>.from(chatRoomId!.map((x) => x)),
        "socialLinksId": socialLinksId,
        "bio": bio,
        "status": status,
        "platformFee": platformFee,
        "weddingDetail": weddingDetail?.toJson(),
        "profilePic": profilePic,
      };
}

class WeddingDetail {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final DateTime? date;
  final dynamic location;
  final dynamic geoLocation;
  final dynamic referralCode;
  final dynamic eventId;
  final String? city;
  final String? type;
  final int? noOfGuests;

  WeddingDetail({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.date,
    this.location,
    this.geoLocation,
    this.referralCode,
    this.eventId,
    this.city,
    this.type,
    this.noOfGuests,
  });

  factory WeddingDetail.fromJson(Map<String, dynamic> json) => WeddingDetail(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        location: json["location"],
        geoLocation: json["geoLocation"],
        referralCode: json["referralCode"],
        eventId: json["eventId"],
        city: json["city"],
        type: json["type"],
        noOfGuests: json["noOfGuests"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "date": date?.toIso8601String(),
        "location": location,
        "geoLocation": geoLocation,
        "referralCode": referralCode,
        "eventId": eventId,
        "city": city,
        "type": type,
        "noOfGuests": noOfGuests,
      };
}
