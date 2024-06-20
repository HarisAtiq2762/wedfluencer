import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../infrastructure/resources/post/post_repository.dart';
import '../../../models/post/post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final repository = PostRepository();

  PostBloc() : super(PostInitial()) {
    on<GetPosts>((event, emit) async {
      try {
        final posts = await repository.getPosts(isImage: event.isImage);
        emit(GotPosts(posts: posts, isImage: event.isImage));
      } catch (e) {
        emit(PostError(error: e.toString()));
        emit(PostInitial());
      }
    });
  }
}
