import 'dart:async';
import 'dart:io';

import '../../../models/user.dart';
import '../../../presentation/ui/config/globals.dart';
import '../../network_service_layer/api_handler.dart';

String serverUrl = serverUrlGlobal;

class AuthenticationProvider {
  final APIService _apiServices = APIService(baseUrl: serverUrl);

  Future<WedfluencerUser> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      print("HEREEEE");
      final response = await _apiServices.apiCall(
        urlExt: 'auth/login',
        type: RequestType.post,
        body: {
          "email": email,
          "password": password,
        },
      );

      print(response);
      WedfluencerUser user = WedfluencerUser.fromJson(response.data['user']);
      user.refreshToken = response.data['token']['refreshToken'];
      user.accessToken = response.data['token']['accessToken'];
      return user;
    } catch (e) {
      print(e.toString());
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<bool> registerEmailAndGetOtp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: 'auth/otp',
        type: RequestType.post,
        body: {
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
        },
      );

      if (response.sucess) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<APIResponseGeneric> verifyOtp({
    required String otp,
    required User user,
  }) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: 'auth/otp/verify',
        type: RequestType.post,
        body: {"email": user.email, "otp": otp, "last": false},
      );

      return response;
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future sendPhoneOtp({
    required String weddingDate,
    required String city,
    required String countyCode,
    required String phone,
    required String weddingType,
    required String phoneNumber,
    required User user,
    required int guests,
  }) async {
    try {
      final response = await _apiServices
          .apiCall(urlExt: 'auth/phone-otp', type: RequestType.post, body: {
        "agree": true,
        "noOfGuests": 120,
        "date": weddingDate,
        "type": weddingType,
        "city": city,
        "countryCode": countyCode,
        "phone": phone,
        "lastname": user.lastName,
        "username": user.userName,
        "firstname": user.firstName,
        "formType": 1,
        "phonenumber": phoneNumber
      });
      return response.data;
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<WedfluencerUser> verifyPhoneOtpAndRegister({
    required String weddingDate,
    required String city,
    required String countyCode,
    required String phone,
    required String weddingType,
    required String phoneNumber,
    required String otp,
    required User user,
    required int guests,
  }) async {
    try {
      final response = await _apiServices
          .apiCall(urlExt: 'auth/register', type: RequestType.post, body: {
        "email": user.email,
        "password": user.password,
        "confirmPassword": user.password,
        "recaptcha": "",
        "provider": "EMAIL",
        "otp": otp,
        "agree": true,
        "noOfGuests": guests,
        "date": weddingDate,
        "type": weddingType,
        "city": city,
        "countryCode": countyCode,
        "phone": phone,
        "lastname": user.lastName,
        "username": user.userName,
        "firstname": user.firstName,
        "formType": 1,
        "phonenumber": phoneNumber
      });

      return WedfluencerUser.fromJson(response.data['user']);
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }
}
