import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/resources/payment/payment_repository.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final repository = PaymentRepository();

  PaymentBloc() : super(PaymentInitial()) {
    on<CreatePaymentSession>((event, emit) async {
      try {
        final sessionId =
            await repository.createSessionOnStripe(videoId: event.videoId);
        emit(PaymentSessionCreated(
            sessionId: sessionId, price: event.amount, videoId: event.videoId));
      } catch (e) {
        emit(PaymentError(error: e.toString()));
        emit(PaymentInitial());
      }
    });
    on<CreatePaymentIntent>((event, emit) async {
      try {
        final paymentIntent = await repository.createPaymentIntent(
            videoId: event.videoId,
            amount: event.amount,
            sessionId: event.sessionId,
            currency: event.currency);
        emit(PaymentIntentCreated(
            paymentIntent: paymentIntent,
            payment: event.amount.toInt(),
            sessionId: event.sessionId));
      } catch (e) {
        emit(PaymentError(error: e.toString()));
        emit(PaymentInitial());
      }
    });

    on<MakePayment>((event, emit) async {
      try {
        final result = await repository.makePayment(
          payment: event.payment,
          currency: 'USD',
          sessionId: event.sessionId,
          clientSecret: event.paymentIntent['client_secret'],
          context: event.context,
        );
        print(result);
        await repository
            .displayPaymentSheet(
                clientSecret: event.paymentIntent['client_secret'])
            .then((value) {
          emit(PaymentMade(clientSecret: event.paymentIntent['client_secret']));
        });
      } catch (e) {
        emit(PaymentError(error: e.toString()));
        emit(PaymentInitial());
      }
    });
  }
}
