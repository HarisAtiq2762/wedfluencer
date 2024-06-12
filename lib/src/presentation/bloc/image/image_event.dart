part of 'image_bloc.dart';

abstract class ImageEvent {}

class GetImages extends ImageEvent {
  final File? file;
  GetImages({this.file});
}

class GetMultipleImages extends ImageEvent {
  final List<XFile> files;
  GetMultipleImages({required this.files});
}
