import 'dart:io';

import 'package:wedfluencer/src/models/post/post.dart';

import 'post_provider.dart';

class PostRepository {
  final postProvider = PostProvider();

  Future<List<Post>> getPosts({required bool isImage}) =>
      postProvider.getPosts(isImage: isImage);
  Future<bool> uploadPost({
    required String title,
    required String description,
    required String categoryId,
    required String location,
    required String hashtags,
    required String id,
    required bool isVideo,
    required bool isEdit,
    required File file,
  }) =>
      postProvider.uploadPost(
          title: title,
          description: description,
          categoryId: categoryId,
          location: location,
          hashtags: hashtags,
          isVideo: isVideo,
          isEdit: isEdit,
          id: id,
          file: file);

  Future<bool> deletePost({required String id}) =>
      postProvider.deletePost(id: id);

  Future<bool> updateReactionLikeDislike({
    required String postId,
    required String reaction,
  }) =>
      postProvider.updateReactionLikeDislike(
        postId: postId,
        reaction: reaction,
      );

  Future<bool> makeFeed({
    required String postId,
  }) =>
      postProvider.makeFeed(
        postId,
      );
}
