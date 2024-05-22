part of 'chat_bloc.dart';

abstract class ChatEvent {}

class GetChats extends ChatEvent {}

class GetChatDetails extends ChatEvent {
  final String id;
  GetChatDetails({required this.id});
}
