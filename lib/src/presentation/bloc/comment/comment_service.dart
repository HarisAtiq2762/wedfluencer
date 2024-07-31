import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/bloc/comment/comment_bloc.dart';

import '../../../infrastructure/dependency_injection.dart';
import '../../ui/templates/comment_widgets/static_widgets/comment_bottom_sheet.dart';

class CommentService {
  void showCommentBottomSheet(
    BuildContext context, {
    required String postId,
  }) {
    fetchComments(
      postId: postId,
    );
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CommentBottomSheet(
          postId: postId,
        );
      },
    );
  }

  //Bloc Triggers

  void sendComment({
    required String postId,
    required String comment,
  }) {
    DI.i<CommentBloc>().add(
          MakeComment(
            postId: postId,
            comment: comment,
          ),
        );
  }

  void fetchComments({
    required String postId,
  }) {
    DI.i<CommentBloc>().add(
          FetchPostComments(
            postId: postId,
          ),
        );
  }
}
