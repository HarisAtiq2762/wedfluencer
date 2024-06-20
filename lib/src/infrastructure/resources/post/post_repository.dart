import 'package:wedfluencer/src/models/post/post.dart';

import 'post_provider.dart';

class PostRepository {
  final postProvider = PostProvider();

  Future<List<Post>> getPosts({required bool isImage}) =>
      postProvider.getPosts(isImage: isImage);
}
