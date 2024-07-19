import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_dropdown/models/value_item.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/auth_repository.dart';
import 'package:wedfluencer/src/infrastructure/network_service_layer/api_handler.dart';
import 'package:wedfluencer/src/models/event_image.dart';
import 'package:wedfluencer/src/models/producer_payment.dart';
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
      {required String accessToken,
      String? range,
      required bool isMe,
      required String skip}) async {
    try {
      final params = {
        'filterBy': 'createdAt',
        'orderBy': 'desc',
        'take': '9',
        'skip': skip,
        'day': range,
      };
      final response = await _apiServices.apiCall(
        urlExt: 'proposal${isMe ? '/me' : ''}',
        queryParameters: params,
        type: RequestType.get,
      );
      return ProposalVideoApiResponse.fromJson(response.data['data']);
    } catch (e) {
      DI
          .i<NavigationService>()
          .showSnackBar(message: e.toString(), error: true);
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
      final body = {
        "videoId": videoId,
        "categoryIds": categoryIds,
        "title": title,
        "eventId": eventId,
      };
      final response = await _apiServices.apiCall(
        urlExt: 'proposal',
        body: body,
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

  Future<List<ProducerEvent>> getProducerEvents(
      {required String take, required String search}) async {
    try {
      List<ProducerEvent> events = [];
      final response = await _apiServices
          .apiCall(urlExt: 'event', type: RequestType.get, queryParameters: {
        'take': take,
        'search': search,
      });
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
      final response = await _apiServices.apiCall(
        urlExt: 'event',
        body: body,
        type: RequestType.post,
      );
      DI.i<NavigationService>().showSnackBar(message: response.message);
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
      return ProducerEvent.fromJson(response.data);
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future updateWeddingDetails({
    required String city,
    required String date,
    required String type,
    required String guestsCount,
  }) async {
    try {
      final body = {
        "date": date,
        "city": city,
        "type": type,
        "noOfGuests": guestsCount,
      };
      final response = await _apiServices.apiCall(
        urlExt: 'user/me/wedding-detail',
        body: body,
        type: RequestType.post,
      );
      if (response.sucess == true && response.statusCode == 201) {
        DI.i<NavigationService>().showSnackBar(
            message: 'Wedding details successfully update',
            color: Colors.green);
        final weddingDetails = DI.i<AuthRepository>().user!.weddingDetails;
        weddingDetails!.city = city;
        weddingDetails.type = type;
        weddingDetails.noOfGuests = int.parse(guestsCount);
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

  Future<List<ProducerPayment>> getPayments({
    required String search,
    required int page,
    required int take,
  }) async {
    try {
      List<ProducerPayment> payments = [];
      final response = await _apiServices.apiCall(
        urlExt: 'event/payments',
        type: RequestType.get,
        queryParameters: {'page': '$page', 'take': '$take', 'search': search},
      );
      response.data['data'].forEach((payment) {
        payments.add(ProducerPayment.fromJson(payment));
      });
      return payments;
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }
}
