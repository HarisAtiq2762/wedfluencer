import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wedfluencer/src/infrastructure/resources/post/post_repository.dart';

part 'reaction_event.dart';
part 'reaction_state.dart';

class ReactionBloc extends Bloc<ReactionEvent, ReactionState> {
  ReactionBloc() : super(ReactionInitial()) {
    final PostRepository postRepository = PostRepository();
    on<UpdateReaction>((event, emit) async {
      try {
        emit(
          AddingReaction(),
        );

        final bool reactionAdded =
            await postRepository.updateReactionLikeDislike(
          postId: event.postId,
          reaction: event.reaction,
        );
        if (reactionAdded) {
          // DI.i<UserHomeBloc>().add(GetExplorePostVideos());
          // DI
          //     .i<NavigationService>()
          //     .showSnackBar(message: "Reaction Successful");
        } else {
          // DI.i<NavigationService>().showSnackBar(message: "Reaction Failed");
        }
        emit(
          ReactionInitial(),
        );
      } catch (e) {
        // DI.i<NavigationService>().showSnackBar(
        //       message: e.toString(),
        //     );
        emit(
          ReactionInitial(),
        );
      }
    });
  }
}
