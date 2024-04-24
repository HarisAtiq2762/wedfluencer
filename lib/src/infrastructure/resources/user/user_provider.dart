import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wedfluencer/src/models/video.dart';

import '../../../presentation/ui/config/globals.dart';

String serverUrl = serverUrlGlobal;

class UserProvider {
  Future<List<VideoData>> getExploreVideos() async {
    try {
      final url = Uri.parse('${serverUrl}user/explore');
      print(url);
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});
      print(response.statusCode);
      print(response.body);
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      List<VideoData> videos = [];
      responseBody['data']['data'].forEach((video) {
        print(video);
        videos.add(VideoData.fromJson(video));
      });
      print(videos);
      return videos;
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }
}
