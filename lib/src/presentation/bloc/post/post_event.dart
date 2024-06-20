part of 'post_bloc.dart';

abstract class PostEvent {}

class GetPosts extends PostEvent {
  final bool isImage;
  final List<Post> posts;
  GetPosts({required this.isImage, required this.posts});
}
