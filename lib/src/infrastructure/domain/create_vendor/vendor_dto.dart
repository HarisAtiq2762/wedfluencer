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
  final List<String> category, subCategory, keywords;

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
      required this.category,
      required this.subCategory,
      required this.keywords});

  Map<String, dynamic> toPhoneJson() {
    return {
      "phonenumber": phoneNumber,
      "username": userName,
    };
  }

  Map<String, dynamic> toJson(String otp) {
    return {
      "firstname": firstName,
      "lastname": lastName,
      "formType": 3,
      "phone": phoneNumber,
      "phonenumber": "+1$phoneNumber",
      "companyName": company,
      "trademarkName": tradeMark,
      "address": secondaryAddress,
      "tollFree": tolFree,
      "website": websiteUrl,
      "catagory": category,
      "subCategory": subCategory,
      "keyword": keywords,
      "service": offeringService,
      "product": offeringProduct,
      "comment": comments,
      "countryCode": 0,
      'otp': otp
    };
  }
}
