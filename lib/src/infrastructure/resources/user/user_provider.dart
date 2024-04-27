import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wedfluencer/src/models/proposal_video_api_response.dart';
import 'package:wedfluencer/src/models/referral_code.dart';
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

  Future<ProposalVideoApiResponse> getProposalVideos(
      {required String accessToken}) async {
    try {
      final url =
          Uri.parse('${serverUrl}proposal/me?filterBy=createdAt&orderBy=desc');
      print(url);
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });
      print(response.statusCode);
      print(response.body);
      final responseBody = jsonDecode(response.body);
      print(responseBody);
      // List<ProposalVideo> videos = [];
      // responseBody['data']['data']['proposalVideos'].forEach((video) {
      //   print(video);
      //   videos.add(ProposalVideo.fromJson(video));
      // });
      print(responseBody);
      return ProposalVideoApiResponse.fromJson(responseBody['data']);
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<String> uploadProposalVideo(
      {required File video,
      required String title,
      required String description}) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
      };
      final request = http.MultipartRequest(
          'POST', Uri.parse('${serverUrl}storage/upload/video'));
      request.fields
          .addAll({'folder': 'proposal', 'desc': description, 'title': title});
      request.files.add(await http.MultipartFile.fromPath('file', video.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print('response');
      print(response);
      print(response.reasonPhrase);
      final responseBody = await response.stream.bytesToString();
      print('responseBody');
      print(responseBody);

      // final url = Uri.parse('${serverUrl}storage/upload/video');
      // print(url);
      // final response = await http.post(url, headers: {
      //   'Content-Type': 'application/json',
      // });
      // print(response.statusCode);
      // print(response.body);
      // final responseBody = jsonDecode(response.body);
      // print(responseBody);
      // print(responseBody);
      // return response['data']['id']
      return jsonDecode(responseBody)['data']['id'];
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future uploadProposalDetails({
    required String accessToken,
    required String videoId,
    required List<String> categoryIds,
    required String title,
    required String eventId,
  }) async {
    try {
      final url = Uri.parse('${serverUrl}proposal');
      print(url);
      final body = jsonEncode({
        "videoId": videoId,
        "categoryIds": categoryIds,
        "title": title,
        "eventId": eventId,
      });
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: body,
      );
      print(response.statusCode);
      print(response.body);
      final responseBody = jsonDecode(response.body);
      print('responseBody of uploadProposalDetails');
      print(responseBody);
      return responseBody;
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<ReferralCode> verifyReferralCode(
      {required String referralCode}) async {
    try {
      final url = Uri.parse('${serverUrl}event/ref?ref=$referralCode');
      print(url);
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});
      print(response.statusCode);
      print(response.body);
      final responseBody = jsonDecode(response.body);
      print('responseBody of uploadProposalDetails');
      print(responseBody);
      return ReferralCode.fromJson(responseBody['data']);
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }
}
