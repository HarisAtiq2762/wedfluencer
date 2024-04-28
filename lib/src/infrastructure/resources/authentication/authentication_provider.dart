import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../models/user.dart';
import '../../../presentation/ui/config/globals.dart';
import '../../network_service_layer/api_handler.dart';

String serverUrl = serverUrlGlobal;

class AuthenticationProvider {
  final APIService _apiServices = APIService(baseUrl: serverUrl);
  // final headers = {'Authorization': 'Bearer $userTokenGlobal'};

  Future<WedfluencerUser> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: 'auth/login',
        type: RequestType.post,
        body: {
          "email": email,
          "password": password,
        },
      );
      // final url = Uri.parse('${serverUrl}auth/login');
      // print(url);
      // var body = jsonEncode({
      //   "email": email,
      //   "password": password,
      // });
      // print(body);

      // final response = await http.post(
      //   url,
      //   headers: {
      //     // 'Authorization': 'Bearer $userTokenGlobal',
      //     'Content-Type': 'application/json'
      //   },
      //   body: body,
      // );
      // print(response.statusCode);
      // print(response.body);
      // final responseBody = jsonDecode(response.body);
      // print(responseBody);
      // print(responseBody['status']);
      WedfluencerUser user = WedfluencerUser.fromJson(response.data['user']);
      user.refreshToken = response.data['token']['refreshToken'];
      user.accessToken = response.data['token']['accessToken'];
      // print(user.accessToken);
      return user;
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future registerEmailAndGetOtp({
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

      // final url = Uri.parse('${serverUrl}auth/otp');
      // print(url);
      // var body = jsonEncode({
      //   "email": email,
      //   "password": password,
      //   "confirmPassword": confirmPassword,
      // });
      // print(body);

      // final response = await http.post(
      //   url,
      //   headers: {
      //     // 'Authorization': 'Bearer $userTokenGlobal',
      //     'Content-Type': 'application/json'
      //   },
      //   body: body,
      // );
      // print(response.statusCode);
      // print(response.body);
      // final responseBody = jsonDecode(response.body);
      // print(responseBody);
      // print(responseBody['status']);
      // error500 = responseBody['message'];
      if (response.statusCode >= 500 && response.statusCode <= 599) {
        // throw error500;
      } else if (response.statusCode >= 400 && response.statusCode <= 499) {
        // throw error500;
        // return false;
      } else {
        if (response.sucess) {
          return response.data;
        } else {
          return {
            'success': response.sucess,
            // 'message': responseBody['message']
          };
        }
      }
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future verifyOtp({
    required String otp,
    required User user,
  }) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: 'auth/otp/verify',
        type: RequestType.post,
        body: {"email": user.email, "otp": otp, "last": false},
      );

      // final url = Uri.parse('${serverUrl}auth/otp/verify');
      // print(url);
      // var body = json.encode({"email": user.email, "otp": otp, "last": false});
      // print(body);

      // final response = await http.post(
      //   url,
      //   headers: {
      //     // 'Authorization': 'Bearer $userTokenGlobal',
      //     'Content-Type': 'application/json'
      //   },
      //   body: body,
      // );
      // print(response.statusCode);
      // print(response.body);
      // final responseBody = jsonDecode(response.body);
      // print(responseBody);
      // print(responseBody['status']);
      // error500 = responseBody['message'];
      // if (response.statusCode >= 500 && response.statusCode <= 599) {
      //   // throw error500;
      // } else if (response.statusCode >= 400 && response.statusCode <= 499) {
      //   // throw error500;
      //   // return false;
      // } else {
      return response.data;
      // }
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
      final url = Uri.parse('${serverUrl}auth/phone-otp');
      print(url);
      var body = json.encode({
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
      print(body);

      final response = await http.post(
        url,
        headers: {
          // 'Authorization': 'Bearer $userTokenGlobal',
          'Content-Type': 'application/json'
        },
        body: body,
      );
      print(response.statusCode);
      print(response.body);
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      print(responseBody['status']);
      // error500 = responseBody['message'];
      // if (response.statusCode >= 500 && response.statusCode <= 599) {
      //   // throw error500;
      // } else if (response.statusCode >= 400 && response.statusCode <= 499) {
      //   // throw error500;
      //   // return false;
      // } else {
      return responseBody;
      // }
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
      final url = Uri.parse('${serverUrl}auth/register');
      print(url);
      var body = json.encode({
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
      print(body);

      final response = await http.post(
        url,
        headers: {
          // 'Authorization': 'Bearer $userTokenGlobal',
          'Content-Type': 'application/json'
        },
        body: body,
      );
      print(response.statusCode);
      print(response.body);
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      print(responseBody['status']);

      return WedfluencerUser.fromJson(responseBody['data']['user']);

      // error500 = responseBody['message'];
      // if (response.statusCode >= 500 && response.statusCode <= 599) {
      //   // throw error500;
      // } else if (response.statusCode >= 400 && response.statusCode <= 499) {
      //   // throw error500;
      //   // return false;
      // } else {
      // return responseBody;
      // }
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }
}
