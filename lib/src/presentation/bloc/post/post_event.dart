part of 'post_bloc.dart';

abstract class PostEvent {}

class GetPosts extends PostEvent {
  final bool isImage;
  final List<Post> posts;

  GetPosts({required this.isImage, required this.posts});
}

class DeletePost extends PostEvent {
  final String id;

  DeletePost({required this.id});
}

class UploadPost extends PostEvent {
  final String title;
  final String description;
  final String categoryId;
  final String location;
  final String id;
  final String hashtags;
  final bool isVideo;
  final File file;
  final bool isEdit;

  UploadPost({
    required this.title,
    required this.description,
    required this.categoryId,
    required this.location,
    required this.hashtags,
    required this.isVideo,
    required this.file,
    required this.isEdit,
    required this.id,
  });
}
