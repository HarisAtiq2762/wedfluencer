import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<GetImages>((event, emit) async {
      emit(GotImages(file: event.file));
    });
    on<GetMultipleImages>((event, emit) async {
      emit(GotMultipleImages(files: event.files));
    });
  }
}
