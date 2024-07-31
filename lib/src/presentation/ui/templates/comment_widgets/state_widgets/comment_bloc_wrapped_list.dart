import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/presentation/ui/templates/custom_widgets/no_generic_text_widget.dart';

import '../../../../../models/comment/comment.dart';
import '../../../../bloc/comment/comment_bloc.dart';
import '../../custom_widgets/circle_rounded_loader.dart';
import '../static_widgets/single_comment.dart';

class CommentBlocWrappedList extends StatelessWidget {
  const CommentBlocWrappedList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, commentState) {
        if (commentState is CommentsFetched) {
          final List<Comment> comments = commentState.fetchedComments;
          return Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return SingleComment(
                  comment: comment,
                );
              },
            ),
          );
        }
        if (commentState is FetchingPostComments) {
          return const Expanded(child: CircleRoundedLoader());
        }
        return const Expanded(
          child: NoGenericTextFound(text: 'comments'),
        );
      },
    );
  }
}
