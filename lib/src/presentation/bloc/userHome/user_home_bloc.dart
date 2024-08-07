import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/resources/post/post_repository.dart';
import 'package:wedfluencer/src/infrastructure/resources/user/user_repository.dart';

import '../../../models/post/explore_post.dart';
import '../../../models/video.dart';

part 'user_home_event.dart';
part 'user_home_state.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  final repository = UserRepository();
  final postRepository = PostRepository();

  UserHomeBloc() : super(UserHomeInitial()) {
    on<GetExploreVideos>((event, emit) async {
      emit(UserHomeLoading());
      try {
        final result = await repository.getExploreVideos();
        emit(GotExploreVideos(videos: result));
      } catch (e) {
        emit(UserHomeError(error: e.toString()));
        emit(UserHomeInitial());
      }
    });

    on<GetExplorePostVideos>((event, emit) async {
      emit(
        UserHomeLoading(),
      );
      try {
        final List<ExplorePost> explorePosts =
            await postRepository.getExplorePosts();
        emit(
          FetchedExplorePostVideos(
            explorePostList: explorePosts,
          ),
        );
      } catch (e) {
        emit(UserHomeError(error: e.toString()));
        emit(UserHomeInitial());
      }
    });
  }
}
