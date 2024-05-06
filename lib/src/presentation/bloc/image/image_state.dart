part of 'image_bloc.dart';

abstract class ImageState {}

class GotImages extends ImageState {
  final File? file;

  GotImages({this.file});
}

class ImageError extends ImageState {
  final String error;

  ImageError({required this.error});
}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}
