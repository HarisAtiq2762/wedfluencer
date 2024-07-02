part of 'producer_events_bloc.dart';

abstract class ProducerEventsEvent {}

class GetProducerEvents extends ProducerEventsEvent {
  final String take;
  final String search;
  GetProducerEvents({required this.take, required this.search});
}
