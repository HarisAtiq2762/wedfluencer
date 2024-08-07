part of 'producer_payment_bloc.dart';

abstract class ProducerPaymentsEvent {}

class GetProducerPayments extends ProducerPaymentsEvent {
  final String search;
  final int page;
  final int take;
  GetProducerPayments(
      {required this.take, required this.page, required this.search});
}
