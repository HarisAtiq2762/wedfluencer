class BlobStorageAccount {
  final String id;
  final String account;
  final String url;

  BlobStorageAccount({
    required this.id,
    required this.account,
    required this.url,
  });

  factory BlobStorageAccount.fromJson(Map<String, dynamic> json) =>
      BlobStorageAccount(
        id: json["id"].toString(),
        account: json["account"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "account": account,
        "url": url,
      };
}
