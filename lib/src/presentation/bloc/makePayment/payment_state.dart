part of 'payment_bloc.dart';

abstract class PaymentState {}

class PaymentSessionCreated extends PaymentState {
  final String sessionId;
  final String videoId;
  final double price;

  PaymentSessionCreated(
      {required this.sessionId, required this.price, required this.videoId});
}

class PaymentError extends PaymentState {
  final String error;

  PaymentError({required this.error});
}

class PaymentIntentCreated extends PaymentState {
  final Map paymentIntent;
  final int payment;
  final String sessionId;

  PaymentIntentCreated(
      {required this.paymentIntent,
      required this.sessionId,
      required this.payment});
}

class PaymentMade extends PaymentState {
  final String clientSecret;

  PaymentMade({required this.clientSecret});
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}
