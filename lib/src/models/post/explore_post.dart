import 'dart:convert';

import '../../infrastructure/resources/helper_services/data_validator.dart';

class ExplorePost {
  final Id id;
  final String title;
  final String description;
  final bool isFeed;
  final String postType;
  final String url;
  final String location;
  final String language;
  final int numberOfLikes;
  final int numberOfViews;
  final int numberOfShares;
  final int numberOfComments;
  final Category category;
  final User user;
  final FileClass file;
  final bool liked;
  final bool shared;
  final bool viewed;
  final String explorePostId;
  final String userId;
  final DateTime createdAt;

  ExplorePost({
    required this.id,
    required this.title,
    required this.description,
    required this.isFeed,
    required this.postType,
    required this.url,
    required this.location,
    required this.language,
    required this.numberOfLikes,
    required this.numberOfViews,
    required this.numberOfShares,
    required this.numberOfComments,
    required this.category,
    required this.user,
    required this.file,
    required this.liked,
    required this.shared,
    required this.viewed,
    required this.explorePostId,
    required this.userId,
    required this.createdAt,
  });

  factory ExplorePost.fromRawJson(String str) =>
      ExplorePost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExplorePost.fromJson(Map<String, dynamic> json) => ExplorePost(
        id: json['_id'] != null ? Id.fromJson(json["_id"]) : _defaultId,
        title: DataValidator.validateData(json["title"], String),
        description: DataValidator.validateData(json["description"], String),
        isFeed: DataValidator.validateData(json["isFeed"], bool),
        postType: DataValidator.validateData(json["postType"], String),
        url: DataValidator.validateData(json["url"], String),
        location: DataValidator.validateData(json["location"], String),
        language: DataValidator.validateData(json["language"], String),
        numberOfLikes: DataValidator.validateData(json["numberOfLikes"], int),
        numberOfViews: DataValidator.validateData(json["numberOfViews"], int),
        numberOfShares: DataValidator.validateData(json["numberOfShares"], int),
        numberOfComments:
            DataValidator.validateData(json["numberOfComments"], int),
        category: json["category"] != null
            ? Category.fromJson(json["category"])
            : _defaultCategory,
        user: json["user"] != null ? User.fromJson(json["user"]) : _defaultUser,
        file: json["file"] != null
            ? FileClass.fromJson(json["file"])
            : _fileClass,
        liked: DataValidator.validateData(json["liked"], bool),
        shared: DataValidator.validateData(json["shared"], bool),
        viewed: DataValidator.validateData(json["viewed"], bool),
        explorePostId: DataValidator.validateData(json["id"], bool),
        userId: DataValidator.validateData(json["userId"], String),
        createdAt: DateTime.parse(json["createdAt"] ?? DateTime.now()),
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "title": title,
        "description": description,
        "isFeed": isFeed,
        "postType": postType,
        "url": url,
        "location": location,
        "language": language,
        "numberOfLikes": numberOfLikes,
        "numberOfViews": numberOfViews,
        "numberOfShares": numberOfShares,
        "numberOfComments": numberOfComments,
        "category": category.toJson(),
        "user": user.toJson(),
        "file": file.toJson(),
        "liked": liked,
        "shared": shared,
        "viewed": viewed,
        "id": explorePostId,
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
      };
}

class Category {
  final String title;
  final String id;

  Category({
    required this.title,
    required this.id,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        title: DataValidator.validateData(json["title"], String),
        id: DataValidator.validateData(json["id"], String),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
      };
}

Category _defaultCategory = Category(
  title: '-1',
  id: '-1',
);

class FileClass {
  final String url;
  final String type;
  final String streamUrl;
  final String thumbnail;
  final String mediaType;
  final String id;

  FileClass({
    required this.url,
    required this.type,
    required this.streamUrl,
    required this.thumbnail,
    required this.mediaType,
    required this.id,
  });

  factory FileClass.fromRawJson(String str) =>
      FileClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
        url: json["url"] ?? "",
        type: json["type"] ?? "",
        streamUrl: json["streamUrl"] ?? "",
        thumbnail: json["thumbnail"] ?? "",
        mediaType: json["mediaType"] ?? "",
        id: json["id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "type": type,
        "streamUrl": streamUrl,
        "thumbnail": thumbnail,
        "mediaType": mediaType,
        "id": id,
      };
}

FileClass _fileClass = FileClass(
  url: '-1',
  type: '-1',
  streamUrl: '-1',
  thumbnail: '-1',
  mediaType: '-1',
  id: '-1',
);

class Id {
  final String oid;

  Id({
    required this.oid,
  });

  Id copyWith({
    String? oid,
  }) =>
      Id(
        oid: oid ?? this.oid,
      );

  factory Id.fromRawJson(String str) => Id.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        oid: DataValidator.validateData(json["\u0024oid"], String),
      );

  Map<String, dynamic> toJson() => {
        "\u0024oid": oid,
      };
}

Id _defaultId = Id(
  oid: '-1',
);

class User {
  final String username;
  final String firstname;
  final String lastname;
  final String roles;
  final String email;
  final String status;
  final bool isFollower;
  final bool isFollowing;
  final String id;
  final ProfilePic profilePic;

  User({
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.roles,
    required this.email,
    required this.status,
    required this.isFollower,
    required this.isFollowing,
    required this.id,
    required this.profilePic,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: DataValidator.validateData(json["username"], String),
        firstname: DataValidator.validateData(json["firstname"], String),
        lastname: DataValidator.validateData(json["lastname"], String),
        roles: DataValidator.validateData(json["roles"], String),
        email: DataValidator.validateData(json["email"], String),
        status: DataValidator.validateData(json["status"], String),
        isFollower: DataValidator.validateData(json["isFollower"], bool),
        isFollowing: DataValidator.validateData(json["isFollowing"], bool),
        id: DataValidator.validateData(json["id"], String),
        profilePic: json["profilePic"] != null
            ? ProfilePic.fromJson(json["profilePic"])
            : _defaultProfilePic,
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "roles": roles,
        "email": email,
        "status": status,
        "isFollower": isFollower,
        "isFollowing": isFollowing,
        "id": id,
        "profilePic": profilePic.toJson(),
      };
}

User _defaultUser = User(
  username: '-1',
  firstname: '-1',
  lastname: '-1',
  roles: '-1',
  email: '-1',
  status: '-1',
  isFollower: false,
  isFollowing: false,
  id: '-1',
  profilePic: _defaultProfilePic,
);

class ProfilePic {
  final String id;

  ProfilePic({
    required this.id,
  });

  factory ProfilePic.fromRawJson(String str) =>
      ProfilePic.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
        id: DataValidator.validateData(json["id"], String),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

ProfilePic _defaultProfilePic = ProfilePic(id: '-1');
