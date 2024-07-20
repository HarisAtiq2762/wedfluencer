import '../../../models/comment/comment.dart';
import 'comment_provider.dart';

class CommentRepository {
  final commentProvider = CommentProvider();

  Future<List<Comment>> getCommentByPostId(
    String postId,
  ) =>
      commentProvider.getCommentByPostId(
        postId: postId,
      );

  Future<bool> addCommentOnPost({
    required String postId,
    required String comment,
  }) =>
      commentProvider.addCommentOnPost(
        postId: postId,
        comment: comment,
      );

  Future<List<Comment>> getCommentReplies(
    String commentId,
  ) =>
      commentProvider.getCommentReplies(
        commentId: commentId,
      );

  Future<bool> addReplyToCommentOnPost({
    required String postId,
    required String commentReply,
    required String commentId,
    required String parentReplyId,
    required int depth,
  }) =>
      commentProvider.addReplyToCommentOnPost(
        postId: postId,
        commentReply: commentReply,
        commentId: commentId,
        parentReplyId: parentReplyId,
        depth: depth,
      );
}
