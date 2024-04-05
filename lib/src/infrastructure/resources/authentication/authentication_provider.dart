import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../presentation/ui/config/globals.dart';

String serverUrl = serverUrlGlobal;

class AuthenticationProvider {
  // final headers = {'Authorization': 'Bearer $userTokenGlobal'};

  Future registerEmailAndGetOtp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final url = Uri.parse('${serverUrl}auth/otp');
      print(url);
      var body = jsonEncode({
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
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
      print(responseBody['success']);
      // error500 = responseBody['message'];
      if (response.statusCode >= 500 && response.statusCode <= 599) {
        // throw error500;
      } else if (response.statusCode >= 400 && response.statusCode <= 499) {
        // throw error500;
        // return false;
      } else {
        if (responseBody['success'] == true) {
          return responseBody;
        } else {
          return {
            'success': responseBody['success'],
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
}
