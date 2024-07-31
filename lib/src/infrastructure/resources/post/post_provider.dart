import 'dart:async';
import 'dart:io';

import 'package:wedfluencer/src/models/post/post.dart';

import '../../../presentation/ui/config/globals.dart';
import '../../network_service_layer/api_handler.dart';
import '../file_upload/file_upload_repository.dart';

String serverUrl = serverUrlGlobal;

class PostProvider {
  final APIService _apiServices = APIService(baseUrl: serverUrl);
  final String providerUrl = "post/";

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

  // Future<bool> uploadPost({
  //   required String title,
  //   required String id,
  //   required String description,
  //   required String categoryId,
  //   required String location,
  //   required String hashtags,
  //   required bool isVideo,
  //   required bool isEdit,
  //   required File file,
  // }) async {
  //   try {
  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${DI.i<AuthRepository>().accessToken}'
  //     };
  //     var request =
  //         http.MultipartRequest('POST', Uri.parse('${serverUrl}post'));
  //     if (isEdit) {
  //       request =
  //           http.MultipartRequest('PUT', Uri.parse('${serverUrl}post/$id'));
  //     }
  //     request.fields.addAll({
  //       'title': title,
  //       'description': description,
  //       'categoryId': categoryId,
  //       'location': location,
  //       'hashtags': hashtags,
  //       'isVideo': isVideo.toString(),
  //       'newFile': isEdit.toString(),
  //     });
  //     request.files.add(await http.MultipartFile.fromPath('file', file.path));
  //     request.headers.addAll(headers);
  //     http.StreamedResponse response = await request.send();
  //     final responseBody = await response.stream.bytesToString();
  //     final result = jsonDecode(responseBody);
  //     if (result['status'] == true && result['code'] == 200) {
  //       DI.i<NavigationService>().showSnackBar(message: result['message']);
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     if (e is SocketException || e is TimeoutException) {
  //       throw socketExceptionError;
  //     } else {
  //       throw e.toString();
  //     }
  //   }
  // }

  // Future<bool> uploadPostFile({
  //   required String title,
  //   required String id,
  //   required String description,
  //   required String categoryId,
  //   required String location,
  //   required String hashtags,
  //   required bool isVideo,
  //   required bool isEdit,
  //   required File file,
  // }) async {
  //   try {
  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${DI.i<AuthRepository>().accessToken}'
  //     };
  //     var request =
  //         http.MultipartRequest('POST', Uri.parse('${serverUrl}post'));
  //     if (isEdit) {
  //       request =
  //           http.MultipartRequest('PUT', Uri.parse('${serverUrl}post/$id'));
  //     }
  //     request.fields.addAll({
  //       'title': title,
  //       'description': description,
  //       'categoryId': categoryId,
  //       'location': location,
  //       'hashtags': hashtags,
  //       'isVideo': isVideo.toString(),
  //       'newFile': isEdit.toString(),
  //     });
  //     request.files.add(await http.MultipartFile.fromPath('file', file.path));
  //     request.headers.addAll(headers);
  //     http.StreamedResponse response = await request.send();
  //     final responseBody = await response.stream.bytesToString();
  //     final result = jsonDecode(responseBody);
  //     if (result['status'] == true && result['code'] == 200) {
  //       DI.i<NavigationService>().showSnackBar(message: result['message']);
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     if (e is SocketException || e is TimeoutException) {
  //       throw socketExceptionError;
  //     } else {
  //       throw e.toString();
  //     }
  //   }
  // }

  Future<bool> uploadPost({
    required String categoryId,
    required String title,
    required File file,
    required String description,
    required String location,
    required String hashtags,
    required bool isVideo,
  }) async {
    try {
      final result = await FileUploadRepository().uploadFile(
        file: file,
        title: title,
        description: description,
        containerName: 'posts',
        isVideo: isVideo,
      );
      int fileSize = await file.length();
      final fileName = file.path.split('/').last;
      final body = {
        "title": title,
        "hashtags": [hashtags],
        "categoryId": categoryId,
        "description": description,
        "location": location,
        "fileInfo": {
          "filename": fileName,
          "originalname": fileName,
          "requestId": result['requestId'],
          "size": fileSize,
          "mimeType": isVideo ? "video/mp4" : "image/png",
          "uploadFileName": fileName,
          "accountName": result['azureAccountName']
        }
      };
      final response = await _apiServices.apiCall(
        urlExt: 'post',
        body: body,
        type: RequestType.post,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
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

  Future<bool> makeFeed(
    String postId,
  ) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: '${providerUrl}make-feed/$postId',
        type: RequestType.put,
      );
      if (response.statusCode == 200) {
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

  Future<bool> updateReactionLikeDislike({
    required String postId,
    required String reaction,
  }) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: '${providerUrl}reaction',
        type: RequestType.patch,
        body: {
          "postId": postId,
          "action": reaction,
        },
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
