part of 'producer_payment_bloc.dart';

abstract class ProducerPaymentsState {}

class ProducerPaymentsInitial extends ProducerPaymentsState {}

class GotProducerPayments extends ProducerPaymentsState {
  final List<ProducerPayment> payments;
  GotProducerPayments({required this.payments});
}

class ProducerPaymentsError extends ProducerPaymentsState {
  final String error;

  ProducerPaymentsError({required this.error});
}

class ProducerPaymentsLoading extends ProducerPaymentsState {}
