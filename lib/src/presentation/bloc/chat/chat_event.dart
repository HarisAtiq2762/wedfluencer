part of 'chat_bloc.dart';

abstract class ChatEvent {}

class GetChats extends ChatEvent {}

class SendMessage extends ChatEvent {
  final String userId;
  final String message;
  SendMessage({required this.message, required this.userId});
}

class GetChatDetails extends ChatEvent {
  final String id;
  GetChatDetails({required this.id});
}
