import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

enum RequestType { get, post, delete, patch, put }

enum HttpContentType {
  appLicationJson(key: 'application/json');

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
    HttpContentType contentType = HttpContentType.appLicationJson,
    Object? body,
  }) async {
    try {
      Uri uri = Uri(scheme: '', path: urlExt, queryParameters: queryParameters);
      final header = _getHeader(contentType: contentType);
      debugPrint('$urlExt[${type.name}]');
      Response response;
      switch (type) {
        case RequestType.get:
          response = await _api.get(uri, headers: header);
        case RequestType.post:
          response = await _api.post(uri, body: body, headers: header);
        case RequestType.delete:
          response = await _api.delete(uri, headers: header);
        case RequestType.patch:
          response = await _api.patch(uri, headers: header);
        case RequestType.put:
          response = await _api.put(uri, headers: header);
      }
      debugPrint('$urlExt[${response.statusCode}]');

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
    if (response.statusCode == 200) {
      return APIResponseGeneric(
        data: data['data'],
        message: data['message'],
        statusCode: response.statusCode,
        sucess: true,
      );
    } else {
      return APIResponseGeneric(
        message: data['message'],
        sucess: false,
        statusCode: response.statusCode,
      );
    }
  }

  Map<String, String> _getHeader({
    HttpContentType contentType = HttpContentType.appLicationJson,
  }) {
    return {
      // 'Authorization': 'Bearer $userTokenGlobal',
      'Content-Type': contentType.key
    };
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
