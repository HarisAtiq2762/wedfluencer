import 'package:wedfluencer/src/infrastructure/data/auth_api_impl/auth_entity.dart';

import '../../../../models/wedding_details.dart';
import 'image_model.dart';

enum UserRole {
  brideGroom,
  vendor,
  weddingProducer,
  loggedOut,
  weddingPlanner;

  static UserRole getRoleFromString(String roleString) {
    switch (roleString) {
      case 'Vendor' || 'vendor':
        return UserRole.vendor;
      case 'WeddingProducer' || 'weddingProducer':
        return UserRole.weddingProducer;
      case 'BrideGroom' || 'brideGroom':
        return UserRole.brideGroom;
      case 'WeddingPlanner' || 'weddingPlanner':
        return UserRole.weddingPlanner;
      default:
        return UserRole.brideGroom;
    }
  }
}

class UserModel {
  final String _id;
  final String _username;
  final String _firstname;
  final String _lastname;
  final String email;
  final String phonenumber;
  final UserRole role;
  final WeddingDetails? weddingDetails;
  final UploadImageModel? profileImage;
  final int followerCount;
  final int followingCount;

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      username: entity.username,
      firstname: entity.firstname,
      lastname: entity.lastname,
      roles: entity.roles,
      email: entity.email,
      phonenumber: entity.phonenumber,
      followingCount: entity.followingCount,
      followerCount: entity.followersCount,
      role: UserRole.getRoleFromString(entity.roles),
      profileImage: entity.profilePic != null
          ? UploadImageModel.fromEntity(entity.profilePic!)
          : null,
      weddingDetails: entity.weddingDetail,
    );
  }

  String get getFullName => _firstname + _lastname;
  String get userId => _id;
  String get userName => _username;
  bool get isBrideGroom => role == UserRole.brideGroom;
  bool get isVendor => role == UserRole.vendor;
  bool get isWeddingProducer => role == UserRole.weddingProducer;
  bool get isPlanner => role == UserRole.weddingPlanner;

  UserModel({
    required String id,
    required String username,
    required String firstname,
    required String lastname,
    required String roles,
    required this.email,
    required this.phonenumber,
    required this.role,
    required this.profileImage,
    required this.weddingDetails,
    required this.followingCount,
    required this.followerCount,
  })  : _username = username,
        _id = id,
        _lastname = lastname,
        _firstname = firstname;
}
