import 'package:flutter/cupertino.dart';
import 'package:wedfluencer/src/infrastructure/resources/payment/payment_provider.dart';

class PaymentRepository {
  final paymentProvider = PaymentProvider();

  Future<String> createSessionOnStripe({
    required String videoId,
  }) =>
      paymentProvider.createSessionOnStripe(videoId: videoId);

  Future<Map> createPaymentIntent({
    required double amount,
    required String currency,
    required String videoId,
    required String sessionId,
  }) =>
      paymentProvider.createPaymentIntent(amount, currency,
          videoId: videoId, sessionId: sessionId);

  Future<bool> makePayment({
    required int payment,
    required String currency,
    required String sessionId,
    required String clientSecret,
    required BuildContext context,
  }) =>
      paymentProvider.makePayment(
        sessionId: sessionId,
        payment: payment,
        clientSecret: clientSecret,
        context: context,
      );

  Future<void> displayPaymentSheet({required String clientSecret}) =>
      paymentProvider.displayPaymentSheet(clientSecret: clientSecret);
}
