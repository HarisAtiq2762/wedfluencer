part of 'create_event_bloc.dart';

abstract class CreateEventState {}

class CreateEventInitial extends CreateEventState {}

class CreateEventError extends CreateEventState {
  final String error;

  CreateEventError({required this.error});
}

class CreateEventLoading extends CreateEventState {}

class EventCreated extends CreateEventState {
  final ProducerEvent event;
  EventCreated({required this.event});
}

class EventCoordinatesUpdated extends CreateEventState {}

class EventImagesUploaded extends CreateEventState {
  final List<String> imageIds;
  EventImagesUploaded({required this.imageIds});
}
