part of 'producer_events_bloc.dart';

abstract class ProducerEventsState {}

class ProducerEventsInitial extends ProducerEventsState {}

class GotProducerEvents extends ProducerEventsState {
  final List<ProducerEvent> events;
  GotProducerEvents({required this.events});
}

class ProducerEventsError extends ProducerEventsState {
  final String error;

  ProducerEventsError({required this.error});
}

class ProducerEventsLoading extends ProducerEventsState {}
