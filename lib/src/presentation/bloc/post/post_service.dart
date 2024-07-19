import 'package:wedfluencer/src/presentation/bloc/post/post_bloc.dart';

import '../../../infrastructure/dependency_injection.dart';

class PostService {
  void makePostToFeed({
    required String postId,
    required String postType,
  }) {
    DI.i<PostBloc>().add(
          ConvertPostToFeed(
            postId: postId,
            postType: postType,
          ),
        );
  }
}
