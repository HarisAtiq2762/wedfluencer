import 'dart:async';
import 'dart:io';

import 'package:wedfluencer/src/models/chat/charResponseData.dart';
import 'package:wedfluencer/src/models/chat/chatMessageDetails.dart';

import '../../../presentation/ui/config/globals.dart';
import '../../network_service_layer/api_handler.dart';

String serverUrl = serverUrlGlobal;

class ChatProvider {
  final APIService _apiServices = APIService(baseUrl: serverUrl);

  Future getUserChats() async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: 'chat/chatroom/me',
        type: RequestType.get,
      );
      ChatData data = ChatData.fromJson(response.data);
      return data;
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future getChatDetails({required String id}) async {
    try {
      final response = await _apiServices.apiCall(
        urlExt: 'chat/$id',
        type: RequestType.get,
      );
      List<ChatMessageDetails> chatMessageDetails = [];
      response.data.forEach((chatMessageDetail) {
        chatMessageDetails.add(ChatMessageDetails.fromJson(chatMessageDetail));
      });
      return chatMessageDetails;
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }

  Future<void> markAsRead({required String id}) async {
    try {
      await _apiServices.apiCall(
        urlExt: 'chat/chatroom/$id/markasread',
        type: RequestType.post,
      );
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw socketExceptionError;
      } else {
        throw e.toString();
      }
    }
  }
}
