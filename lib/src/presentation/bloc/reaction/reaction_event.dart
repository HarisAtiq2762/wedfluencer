part of 'reaction_bloc.dart';

sealed class ReactionEvent extends Equatable {
  const ReactionEvent();

  @override
  List<Object> get props => [];
}

class UpdateReaction extends ReactionEvent {
  final String postId;
  final String reaction;

  const UpdateReaction({
    required this.postId,
    required this.reaction,
  });
}
