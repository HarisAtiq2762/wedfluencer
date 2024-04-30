class VendorDTO {
  final String company,
      tradeMark,
      firstName,
      lastName,
      userName,
      websiteUrl,
      phoneNumber,
      secondaryAddress,
      tolFree,
      comments;

  final bool offeringProduct, offeringService;
  final List<String> categoryIds, keywords;

  VendorDTO(
      {required this.company,
      required this.tradeMark,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.websiteUrl,
      required this.phoneNumber,
      required this.secondaryAddress,
      required this.tolFree,
      required this.comments,
      required this.offeringProduct,
      required this.offeringService,
      required this.categoryIds,
      required this.keywords});

  Map<String, dynamic> toPhoneJson() {
    return {
      "phonenumber": phoneNumber,
      "username": userName,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "companyName": company,
      "trademarkName": tradeMark,
      "address": secondaryAddress,
      "tollFree": tolFree,
      "website": websiteUrl,
      "categroyId": categoryIds,
      "keyword": keywords,
      "service": offeringService,
      "product": offeringProduct,
      "comment": comments
    };
  }
}
