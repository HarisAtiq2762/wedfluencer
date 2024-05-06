part of 'image_bloc.dart';

abstract class ImageEvent {}

class GetImages extends ImageEvent {
  final File? file;
  GetImages({this.file});
}
