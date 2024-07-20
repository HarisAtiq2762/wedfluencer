import '../../../infrastructure/dependency_injection.dart';
import 'reaction_bloc.dart';

class ReactionService {
  void updateReaction({
    required String postId,
    required String reaction,
  }) {
    DI.i<ReactionBloc>().add(
          UpdateReaction(
            postId: postId,
            reaction: reaction,
          ),
        );
  }
}
