import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:multi_dropdown/models/value_item.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/network_service_layer/api_handler.dart';
import 'package:wedfluencer/src/models/event_image.dart';
import 'package:wedfluencer/src/models/proposal_video_api_response.dart';
import 'package:wedfluencer/src/models/referral_code.dart';
import 'package:wedfluencer/src/models/video.dart';

import '../../../models/producer_event.dart';
import '../../../presentation/ui/config/globals.dart';
import '../../navigation_service.dart';

String serverUrl = serverUrlGlobal;

class UserProvider {
  final APIService _apiServices = APIService(baseUrl: serverUrl);

  Future<List<VideoData>> getExploreVideos() async {
    try {
      final response = await _apiServices.apiCall(
          urlExt: 'user/explore', type: RequestType.get);
      List<VideoData> videos = [];
      response.data['data'].forEach((video) {
        videos.add(VideoData.fromJson(video));
      });
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
      {required String accessToken, required bool isMe}) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: 'proposal${isMe ? '/me' : ''}',
        queryParameters: {
          'filterBy': 'createdAt',
          'orderBy': 'desc',
        },
        type: RequestType.get,
      );
      return ProposalVideoApiResponse.fromJson(response.data['data']);
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
      final responseBody = await response.stream.bytesToString();
      print(responseBody);
      print(responseBody);
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
      final response = await _apiServices.apiCall(
        urlExt: 'proposal',
        body: {
          "videoId": videoId,
          "categoryIds": categoryIds,
          "title": title,
          "eventId": eventId,
        },
        type: RequestType.post,
      );
      return response.data;
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
      final response = await _apiServices.apiCall(
        urlExt: 'event/ref',
        queryParameters: {
          'ref': referralCode,
        },
        type: RequestType.get,
      );
      if (response.data == null) {
        DI
            .i<NavigationService>()
            .showSnackBar(message: 'Referral code not found');
      }
      return ReferralCode.fromJson(response.data);
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<List<ProducerEvent>> getProducerEvents() async {
    try {
      List<ProducerEvent> events = [];
      final response = await _apiServices.apiCall(
        urlExt: 'event',
        type: RequestType.get,
      );
      response.data['data'].forEach((event) {
        events.add(ProducerEvent.fromJson(event));
      });
      return events;
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<EventImage> uploadEventImage({required File file}) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        // 'Auth ': 'Be ${DI.i<AuthRepository>().accessToken}',
      };
      final request = http.MultipartRequest(
          'POST', Uri.parse('${serverUrl}storage/upload'));
      request.fields.addAll({
        'folder': 'event',
      });
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final responseBody = await response.stream.bytesToString();
      return EventImage.fromJson(jsonDecode(responseBody)['data']);
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<ProducerEvent> createEvent({
    required List<ValueItem> categoryIds,
    required List<String> tags,
    required List<String> imageIds,
    required String title,
    required String description,
    required String location,
    required String locationDetails,
    required String referralCode,
    required String timezone,
    required String placeId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      List temp = [];
      categoryIds.forEach((element) {
        temp.add(element.value);
      });
      final body = {
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "location": location,
        "locationDetail": locationDetails,
        "referralCode": referralCode,
        "title": title,
        "tags": tags,
        "categoryIds": temp,
        "description": description,
        "imageIds": imageIds,
        "placeId": placeId,
        "timezone": timezone,
      };
      print(body);
      final response = await _apiServices.apiCall(
        urlExt: 'event',
        body: body,
        type: RequestType.post,
      );
      DI.i<NavigationService>().showSnackBar(message: response.message);
      print(response);
      print(response.statusCode);
      print(response.message);
      print(response.data);
      return ProducerEvent.fromJson(response.data);
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<ProducerEvent> updateEventCoordinates({
    required ProducerEvent producerEvent,
    required double lat,
    required double lng,
  }) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: 'event/${producerEvent.id}/location',
        body: {'latitude': lat, 'longitude': lng},
        type: RequestType.post,
      );
      print(response.message);
      return ProducerEvent.fromJson(response.data);
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }
}
