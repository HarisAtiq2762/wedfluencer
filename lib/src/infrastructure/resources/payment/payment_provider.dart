import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/auth_repository.dart';

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

  Future<Map> createPaymentIntent(double amount, String currency,
      {required String videoId, required String sessionId}) async {
    try {
      Map<String, dynamic> body = {
        'amount': (amount * 100).toInt().toString(),
        'currency': currency,
        'metadata[vendorId]': DI.i<AuthRepository>().user!.userId,
        'metadata[proposalVideoId]': videoId,
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

  Future<void> displayPaymentSheet({required String clientSecret}) async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      if (kDebugMode) {
        print('Error is:---> $e');
      }
    }
  }

  Future<bool> makePayment(
      {required String sessionId,
      required int payment,
      required String clientSecret,
      required BuildContext context}) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Wedfluencer',
          style: ThemeMode.light,
          customFlow: false,
        ),
      );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
