import 'dart:io';

import 'package:wedfluencer/src/models/post/post.dart';

import '../../../models/post/explore_post.dart';
import 'post_provider.dart';

class PostRepository {
  final postProvider = PostProvider();

  Future<List<ExplorePost>> getExplorePosts({
    int pageNumber = 1,
    int recordLimit = 10,
  }) =>
      postProvider.getExplorePosts(
        pageNumber,
        recordLimit,
      );
  Future<List<Post>> getPosts({required bool isImage}) =>
      postProvider.getPosts(isImage: isImage);

  Future<bool> uploadPost({
    required String categoryId,
    required String title,
    required File file,
    required String description,
    required String location,
    required String hashtags,
    required bool isVideo,
  }) =>
      postProvider.uploadPost(
          categoryId: categoryId,
          title: title,
          file: file,
          description: description,
          location: location,
          hashtags: hashtags,
          isVideo: isVideo);

  Future<bool> deletePost({required String id}) =>
      postProvider.deletePost(id: id);

  Future<bool> updateReactionLikeDislike(
          {required String postId, required String reaction}) =>
      postProvider.updateReactionLikeDislike(
          postId: postId, reaction: reaction);

  Future<bool> makeFeed({required String postId}) =>
      postProvider.makeFeed(postId);
}
