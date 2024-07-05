import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wedfluencer/src/infrastructure/navigation_service.dart';
import 'package:wedfluencer/src/models/post/post.dart';

import '../../../presentation/ui/config/globals.dart';
import '../../dependency_injection.dart';
import '../../domain/authentication/auth_repository.dart';
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

  Future<bool> uploadPost({
    required String title,
    required String id,
    required String description,
    required String categoryId,
    required String location,
    required String hashtags,
    required bool isVideo,
    required bool isEdit,
    required File file,
  }) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${DI.i<AuthRepository>().accessToken}'
      };
      var request =
          http.MultipartRequest('POST', Uri.parse('${serverUrl}post'));
      if (isEdit) {
        request =
            http.MultipartRequest('PUT', Uri.parse('${serverUrl}post/$id'));
      }
      request.fields.addAll({
        'title': title,
        'description': description,
        'categoryId': categoryId,
        'location': location,
        'hashtags': hashtags,
        'isVideo': isVideo.toString(),
        'newFile': isEdit.toString(),
      });
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final result = jsonDecode(responseBody);
      if (result['status'] == true && result['code'] == 200) {
        DI.i<NavigationService>().showSnackBar(message: result['message']);
        return true;
      }
      return false;
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<bool> deletePost({
    required String id,
  }) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: 'post/$id',
        type: RequestType.delete,
      );
      if (response.data['success'] == true) {
        return true;
      }

      return false;
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }
}
