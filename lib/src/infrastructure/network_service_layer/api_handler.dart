import 'dart:convert';
import 'package:http/http.dart';
import 'package:wedfluencer/src/infrastructure/data/auth_api_impl/end_point.dart';
import 'dart:developer' as developer;

import '../dependency_injection.dart';
import '../domain/authentication/auth_repository.dart';

enum RequestType { get, post, delete, patch, put }

enum HttpContentType {
  applicationJson(key: 'application/json');

  final String key;
  const HttpContentType({required this.key});
}

class APIService {
  final String baseUrl;
  final _api = Client();
  APIService({required this.baseUrl});

  Future<APIResponseGeneric> apiCall({
    required String urlExt,
    required RequestType type,
    Map<String, dynamic>? queryParameters,
    HttpContentType contentType = HttpContentType.applicationJson,
    Object? body,
  }) async {
    try {
      Uri uri = Uri.parse(
        baseUrl + urlExt,
      );
      if (queryParameters != null) {
        uri = uri.replace(queryParameters: queryParameters);
      }
      final header = _getHeader(contentType: contentType, urlExt: urlExt);
      developer.log('$urlExt[${type.name}]');
      Response response;
      switch (type) {
        case RequestType.get:
          response = await _api.get(uri, headers: header);
        case RequestType.post:
          final encodedBody = jsonEncode(body);
          response = await _api.post(uri, body: encodedBody, headers: header);
        case RequestType.delete:
          response = await _api.delete(uri, headers: header);
        case RequestType.patch:
          response = await _api.patch(uri, headers: header);
        case RequestType.put:
          response = await _api.put(uri, headers: header);
      }
      developer.log('$urlExt[${response.statusCode}]');
      return _responseHandler(response);
    } catch (e) {
      return APIResponseGeneric(
        message: e.toString(),
        sucess: false,
        statusCode: -1,
      );
    }
  }

  APIResponseGeneric _responseHandler(Response response) {
    final data = jsonDecode(response.body);
    if (data != null && data['status'] ?? false) {
      return APIResponseGeneric(
        data: data['data'],
        message: data['message'] ?? '',
        statusCode: response.statusCode,
        sucess: data['status'] ?? false,
      );
    } else {
      return APIResponseGeneric(
        message: data['message'] ?? '',
        sucess: false,
        statusCode: response.statusCode,
      );
    }
  }

  Map<String, String> _getHeader(
      {HttpContentType contentType = HttpContentType.applicationJson,
      required String urlExt}) {
    final header = {'Content-Type': contentType.key};
    final authEndPoint = AuthEndPoint();

    if (![authEndPoint.signIn].contains(urlExt)) {
      header['Authorization'] = 'Bearer ${DI.i<AuthRepository>().accessToken}';
    }

    return header;
  }
}

class APIResponseGeneric {
  final dynamic data;
  final bool sucess;
  final String message;
  final int statusCode;

  const APIResponseGeneric({
    this.data,
    this.sucess = false,
    required this.message,
    required this.statusCode,
  });
}
