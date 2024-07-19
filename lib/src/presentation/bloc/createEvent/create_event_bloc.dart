import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:wedfluencer/src/infrastructure/resources/user/user_repository.dart';
import 'package:wedfluencer/src/models/producer_event.dart';

part 'create_event_event.dart';
part 'create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final repository = UserRepository();

  CreateEventBloc() : super(CreateEventInitial()) {
    on<UploadEventImages>((event, emit) async {
      emit(CreateEventLoading());
      try {
        List<String> imageIds = [];
        await Future.forEach(event.images, (image) async {
          final result =
              await repository.uploadEventImage(file: File(image.path));
          imageIds.add(result.id!);
        });
        emit(EventImagesUploaded(imageIds: imageIds));
        // await for (final image in event.images) {
        //   final result =
        //       await repository.uploadEventImage(file: File(image.path));
        //   imageIds.add(result.id!);
        // }
        // event.images.forEach((image) async {
        //   final result =
        //       await repository.uploadEventImage(file: File(image.path));
        //   imageIds.add(result.id!);
        //   print(imageIds);
        //   if (imageIds.length == event.images.length) {
        //     emit(EventImagesUploaded(imageIds: imageIds));
        //   }
        // });
      } catch (e) {
        emit(CreateEventError(error: e.toString()));
        emit(CreateEventInitial());
      }
    });
    on<CreateEvent>((event, emit) async {
      emit(CreateEventLoading());
      try {
        final producerEvent = await repository.createEvent(
          categoryIds: event.categoryIds,
          tags: event.tags,
          imageIds: event.imageIds,
          title: event.title,
          description: event.description,
          location: event.location,
          locationDetails: event.locationDetails,
          referralCode: event.referralCode,
          placeId: event.placeId,
          startDate: event.startDate,
          endDate: event.endDate,
          timezone: event.timezone,
        );
        emit(EventCreated(event: producerEvent));
      } catch (e) {
        emit(CreateEventError(error: e.toString()));
        emit(CreateEventInitial());
      }
    });
    on<UpdateEventCoordinates>((event, emit) async {
      emit(CreateEventLoading());
      try {
        await repository.updateEventCoordinates(
            producerEvent: event.event, lat: event.lat, lng: event.lng);
        emit(EventCoordinatesUpdated());
        emit(CreateEventInitial());
      } catch (e) {
        emit(CreateEventError(error: e.toString()));
        emit(CreateEventInitial());
      }
    });
  }
}
