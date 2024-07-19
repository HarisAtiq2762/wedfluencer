part of 'post_bloc.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostError extends PostState {
  final String error;

  PostError({required this.error});
}

class GotPosts extends PostState {
  final List<Post> posts;
  final bool isImage;

  GotPosts({required this.posts, required this.isImage});
}

class PostDeleted extends PostState {}

class UploadPostSuccess extends PostState {}

//ConvertPostToFeed Event // API: post/make
class ConvertingPostToFeed extends PostState {}

class PostConvertedToFeed extends PostState {}
