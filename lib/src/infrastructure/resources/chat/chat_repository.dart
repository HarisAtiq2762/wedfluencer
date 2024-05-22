import 'package:wedfluencer/src/infrastructure/resources/chat/chat_provider.dart';

class ChatRepository {
  final chatProvider = ChatProvider();

  Future getUserChats() => chatProvider.getUserChats();

  Future getChatDetails({required String id}) =>
      chatProvider.getChatDetails(id: id);

  Future markAsRead({required String id}) => chatProvider.markAsRead(id: id);
}
