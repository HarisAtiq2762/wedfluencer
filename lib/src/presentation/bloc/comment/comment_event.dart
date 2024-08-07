part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class FetchPostComments extends CommentEvent {
  const FetchPostComments({
    required this.postId,
  });
  final String postId;
}

class MakeComment extends CommentEvent {
  const MakeComment({
    required this.postId,
    required this.comment,
  });
  final String postId;
  final String comment;
}
