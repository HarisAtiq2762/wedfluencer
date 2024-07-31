part of 'comment_bloc.dart';

sealed class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

final class CommentInitial extends CommentState {}

final class FetchingPostComments extends CommentState {}

final class CommentsFetched extends CommentState {
  const CommentsFetched({
    required this.fetchedComments,
  });
  final List<Comment> fetchedComments;
}
