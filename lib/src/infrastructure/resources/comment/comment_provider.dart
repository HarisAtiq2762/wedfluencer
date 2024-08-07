import 'dart:async';
import 'dart:io';

import '../../../models/comment/comment.dart';
import '../../../presentation/ui/config/globals.dart';
import '../../network_service_layer/api_handler.dart';

String serverUrl = serverUrlGlobal;

class CommentProvider {
  final APIService _apiServices = APIService(baseUrl: serverUrl);
  final String providerUrl = "comment/";

  Future<List<Comment>> getCommentByPostId({required String postId}) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: providerUrl + postId,
        type: RequestType.get,
      );
      List<Comment> fetchedComments = [];
      response.data.forEach((comment) {
        fetchedComments.add(Comment.fromJson(comment));
      });
      return fetchedComments;
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<bool> addCommentOnPost({
    required String postId,
    required String comment,
  }) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: "$providerUrl$postId",
        type: RequestType.post,
        body: {
          "comment": comment,
        },
      );
      // if (response.sucess) {
      return true;
      // } else {
      //   return false;
      // }
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<List<Comment>> getCommentReplies({required String commentId}) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: "$providerUrl$commentId/reply",
        type: RequestType.get,
      );
      List<Comment> fetchedComments = [];
      response.data['data'].forEach((comment) {
        fetchedComments.add(Comment.fromJson(comment));
      });
      return fetchedComments;
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<bool> addReplyToCommentOnPost({
    required String postId,
    required String commentReply,
    required String commentId,
    required String parentReplyId,
    required int depth,
  }) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: providerUrl + postId,
        type: RequestType.post,
        body: {
          "comment": commentReply,
          "commentId": commentId,
          "parentReplyId": parentReplyId,
          "depth": depth,
        },
      );
      if (response.data['statusCode'] == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }
}
