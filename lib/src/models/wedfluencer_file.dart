class WedfluencerFile {
  final String url;
  final String type;
  final String streamUrl;
  final String thumbnail;

  WedfluencerFile({
    required this.url,
    required this.type,
    required this.streamUrl,
    required this.thumbnail,
  });

  factory WedfluencerFile.fromJson(Map<String, dynamic> json) =>
      WedfluencerFile(
        url: json["url"] ?? '',
        type: json["type"] ?? '',
        streamUrl: json["streamUrl"] ?? '',
        thumbnail: json["thumbnail"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "type": type,
        "streamUrl": streamUrl,
        "thumbnail": thumbnail,
      };
}
