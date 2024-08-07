part of 'payment_bloc.dart';

abstract class PaymentEvent {}

class CreatePaymentSession extends PaymentEvent {
  final String videoId;
  final double amount;

  CreatePaymentSession({required this.videoId, required this.amount});
}

class CreatePaymentIntent extends PaymentEvent {
  final double amount;
  final String currency;
  final String sessionId;
  final String videoId;

  CreatePaymentIntent(
      {required this.amount,
      required this.currency,
      required this.sessionId,
      required this.videoId});
}

class MakePayment extends PaymentEvent {
  final Map paymentIntent;
  final int payment;
  final String sessionId;
  final BuildContext context;
  MakePayment(
      {required this.paymentIntent,
      required this.payment,
      required this.context,
      required this.sessionId});
}
