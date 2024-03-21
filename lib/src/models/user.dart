import 'package:flutter/material.dart';

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
  User(
      {required this.email,
      required this.password,
      required this.isInWeddingBusiness,
      required this.isGettingMarried,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.phoneNumber,
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
      };
}
