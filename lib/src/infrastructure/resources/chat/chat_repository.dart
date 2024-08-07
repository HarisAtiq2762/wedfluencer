import 'package:wedfluencer/src/infrastructure/resources/chat/chat_provider.dart';

import '../../../models/chat/charResponseData.dart';

class ChatRepository {
  final chatProvider = ChatProvider();

  Future<ChatData> getUserChats() => chatProvider.getUserChats();

  Future<VendorChatData> getVendorChats() => chatProvider.getVendorChats();

  Future getChatDetails({required String id}) =>
      chatProvider.getChatDetails(id: id);

  Future markAsRead({required String id}) => chatProvider.markAsRead(id: id);

  Future sendMessage({required String id, required String message}) =>
      chatProvider.sendMessage(id: id, message: message);
}
