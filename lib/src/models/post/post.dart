class Post {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String location;
  final dynamic geoLocation;
  final dynamic language;
  final String postType;
  final String url;
  final int numberOfLikes;
  final int numberOfViews;
  final int numberOfShares;
  final int numberOfComments;
  final int numberOfDislikes;
  // need is liked by user
  final Category category;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.location,
    required this.geoLocation,
    required this.language,
    required this.postType,
    required this.url,
    required this.numberOfLikes,
    required this.numberOfViews,
    required this.numberOfShares,
    required this.numberOfComments,
    required this.numberOfDislikes,
    required this.category,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"] ?? '',
        userId: json["userId"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        location: json["location"] ?? '',
        geoLocation: json["geoLocation"] ?? '',
        language: json["language"] ?? '',
        postType: json["postType"] ?? '',
        url: json["url"] ?? '',
        numberOfLikes: json["numberOfLikes"] ?? 0,
        numberOfViews: json["numberOfViews"] ?? 0,
        numberOfShares: json["numberOfShares"] ?? 0,
        numberOfComments: json["numberOfComments"] ?? 0,
        numberOfDislikes: json["numberOfDislikes"] ?? 0,
        category: json.containsKey('category')
            ? Category.fromJson(json["category"])
            : Category(id: '', title: ''),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "description": description,
        "location": location,
        "geoLocation": geoLocation,
        "language": language,
        "postType": postType,
        "url": url,
        "numberOfLikes": numberOfLikes,
        "numberOfViews": numberOfViews,
        "numberOfShares": numberOfShares,
        "numberOfComments": numberOfComments,
        "numberOfDislikes": numberOfDislikes,
        "category": category.toJson(),
      };
}

class Category {
  final String id;
  final String title;

  Category({
    required this.id,
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
