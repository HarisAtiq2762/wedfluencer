part of 'create_event_bloc.dart';

abstract class CreateEventEvent {}

class UploadEventImages extends CreateEventEvent {
  final File image;

  UploadEventImages({required this.image});
}

class CreateEvent extends CreateEventEvent {
  final List<ValueItem> categoryIds;
  final List<String> tags;
  final List<String> imageIds;
  final String title;
  final String description;
  final String location;
  final String locationDetails;
  final String referralCode;
  final String placeId;
  final DateTime startDate;
  final DateTime endDate;
  final String timezone;

  CreateEvent({
    required this.title,
    required this.placeId,
    required this.description,
    required this.categoryIds,
    required this.tags,
    required this.referralCode,
    required this.locationDetails,
    required this.location,
    required this.endDate,
    required this.startDate,
    required this.imageIds,
    required this.timezone,
  });
}

class UpdateEventCoordinates extends CreateEventEvent {
  final ProducerEvent event;
  final double lat;
  final double lng;

  UpdateEventCoordinates(
      {required this.event, required this.lat, required this.lng});
}
