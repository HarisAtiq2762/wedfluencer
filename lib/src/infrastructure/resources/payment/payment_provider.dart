import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../presentation/ui/config/globals.dart';
import '../../network_service_layer/api_handler.dart';

String serverUrl = serverUrlGlobal;

class PaymentProvider {
  final APIService _apiServices = APIService(baseUrl: serverUrl);

  Future<String> createSessionOnStripe({
    required String videoId,
  }) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: 'stripe/create-session?proposalVideoId=$videoId',
        type: RequestType.get,
      );
      return response.data['sessionId'];
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future createPaymentIntent(double amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount.toInt().toString(),
        'currency': currency,
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51O4T4xClLCURD3NwcHDyFG6FomD2HYCy80frBfvIdeBHZH8qxcVmMbShC0Aj305i52wetgctfV0z7IjszUULQqXv00tYVuFtBo',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print('response.body');
      print(response.body);
      print('response.statusCode');
      print(response.statusCode);
      print('response.reasonPhrase');
      print(response.reasonPhrase);
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
