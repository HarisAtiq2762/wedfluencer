import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wedfluencer/src/infrastructure/resources/comment/comment_repository.dart';
import 'package:wedfluencer/src/presentation/bloc/comment/comment_service.dart';

import '../../../models/comment/comment.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    final CommentRepository commentRepository = CommentRepository();
    on<FetchPostComments>((event, emit) async {
      try {
        emit(FetchingPostComments());
        List<Comment> fetchedComments =
            await commentRepository.getCommentByPostId(
          event.postId,
        );
        fetchedComments = fetchedComments.reversed.toList();
        emit(CommentsFetched(
          fetchedComments: fetchedComments,
        ));
      } catch (e) {
        emit(CommentInitial());
      }
    });

    on<MakeComment>((event, emit) async {
      try {
        final bool isSuccessful = await commentRepository.addCommentOnPost(
          postId: event.postId,
          comment: event.comment,
        );
        if (isSuccessful) {
          List<Comment> fetchedComments =
              await commentRepository.getCommentByPostId(
            event.postId,
          );
          fetchedComments = fetchedComments.reversed.toList();
          emit(CommentsFetched(
            fetchedComments: fetchedComments,
          ));
        }
      } catch (e) {
        CommentService().fetchComments(
          postId: event.postId,
        );
      }
    });
  }
}
