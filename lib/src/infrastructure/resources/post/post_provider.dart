import 'dart:async';
import 'dart:io';

import 'package:wedfluencer/src/models/post/post.dart';

import '../../../presentation/ui/config/globals.dart';
import '../../network_service_layer/api_handler.dart';

String serverUrl = serverUrlGlobal;

class PostProvider {
  final APIService _apiServices = APIService(baseUrl: serverUrl);

  Future<List<Post>> getPosts({required bool isImage}) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt:
            'post?postType=${isImage ? 'Image' : 'Video'}&skip=0&page=1&take=10&filterBy=createdAt&orderBy=desc',
        type: RequestType.get,
      );
      List<Post> posts = [];
      response.data['data'].forEach((post) {
        posts.add(Post.fromJson(post));
      });
      return posts;
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }
}
