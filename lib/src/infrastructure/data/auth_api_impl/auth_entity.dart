class UserEntity {
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String provider;
  dynamic facebookId;
  String username;
  String firstname;
  String lastname;
  String roles;
  String email;
  String phonenumber;
  String profilePicId;
  dynamic weddingDetailId;
  dynamic venderDetailId;
  List<dynamic> chatRoomId;
  dynamic socialLinksId;
  dynamic bio;
  String status;
  int platformFee;
  dynamic weddingDetail;
  dynamic venderDetail;
  UploadImageEntity? profilePic;
  List<dynamic> feedCategoriesOnUser;

  UserEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.provider,
    required this.facebookId,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.roles,
    required this.email,
    required this.phonenumber,
    required this.profilePicId,
    required this.weddingDetailId,
    required this.venderDetailId,
    required this.chatRoomId,
    required this.socialLinksId,
    required this.bio,
    required this.status,
    required this.platformFee,
    required this.weddingDetail,
    required this.venderDetail,
    required this.profilePic,
    required this.feedCategoriesOnUser,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json["id"] ?? '',
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"] == null
            ? null
            : DateTime.parse(json["deletedAt"]),
        provider: json["provider"] ?? '',
        facebookId: json["facebookId"],
        username: json["username"] ?? '',
        firstname: json["firstname"] ?? '',
        lastname: json["lastname"] ?? '',
        roles: json["roles"] ?? "",
        email: json["email"] ?? '',
        phonenumber: json["phonenumber"] ?? "",
        profilePicId: json["profilePicId"] ?? '',
        weddingDetailId: json["weddingDetailId"],
        venderDetailId: json["venderDetailId"],
        chatRoomId: json["chatRoomId"] == null
            ? []
            : List<dynamic>.from(json["chatRoomId"].map((x) => x)),
        socialLinksId: json["socialLinksId"],
        bio: json["bio"] ?? "",
        status: json["status"] ?? "",
        platformFee: json["platformFee"] ?? 0,
        weddingDetail: json["weddingDetail"],
        venderDetail: json["venderDetail"],
        profilePic: json["profilePic"] == null
            ? null
            : UploadImageEntity.fromJson(json["profilePic"]),
        feedCategoriesOnUser: json["FeedCategoriesOnUser"] == null
            ? []
            : List<dynamic>.from(json["FeedCategoriesOnUser"].map((x) => x)),
      );
}

class UploadImageEntity {
  String id;
  DateTime? createdAt;
  String filename;
  String originalname;
  int size;
  String url;
  String type;
  dynamic streamUrl;
  dynamic thumbnail;
  String mediaType;
  String requestId;
  List<dynamic> eventId;

  UploadImageEntity({
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

  factory UploadImageEntity.fromJson(Map<String, dynamic> json) =>
      UploadImageEntity(
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
}

class TokenEntity {
  final String accessToken;
  final String refreshToken;

  const TokenEntity({required this.accessToken, required this.refreshToken});

  factory TokenEntity.fromJson(Map<String, dynamic> json) {
    return TokenEntity(
        accessToken: json['accessToken'], refreshToken: json['refreshToken']);
  }
}

class VenderDetail {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String address;
  final String tollFree;
  final String website;
  final bool product;
  final bool service;
  final String companyName;
  final String trademarkName;
  final List<String> keyword;
  final String comment;
  final List<String> categroyId;
  final dynamic verified;
  final dynamic rejectedReason;

  VenderDetail({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.address,
    required this.tollFree,
    required this.website,
    required this.product,
    required this.service,
    required this.companyName,
    required this.trademarkName,
    required this.keyword,
    required this.comment,
    required this.categroyId,
    this.verified,
    this.rejectedReason,
  });

  factory VenderDetail.fromJson(Map<String, dynamic> json) {
    return VenderDetail(
      id: json["id"] ?? '',
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt:
          json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      deletedAt:
          json["deletedAt"] == null ? null : DateTime.parse(json["deletedAt"]),
      address: json["address"] ?? '',
      tollFree: json["tollFree"] ?? '',
      website: json["website"] ?? '',
      product: json["product"] ?? false,
      service: json["service"] ?? false,
      companyName: json["companyName"] ?? '',
      trademarkName: json["trademarkName"] ?? '',
      keyword: List<String>.from(json["keyword"].map((x) => x)),
      comment: json["comment"] ?? '',
      categroyId: List<String>.from(json["categroyId"].map((x) => x)),
      verified: json["verified"],
      rejectedReason: json["rejectedReason"],
    );
  }
}
