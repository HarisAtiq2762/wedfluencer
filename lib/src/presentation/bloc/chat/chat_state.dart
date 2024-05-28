part of 'chat_bloc.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatError extends ChatState {
  final String error;

  ChatError({required this.error});
}

class ChatLoading extends ChatState {}

// class MessageSent extends ChatState {}

class GotUserChats extends ChatState {
  final ChatData chatData;
  GotUserChats({required this.chatData});
}

class GotChatDetails extends ChatState {
  final List<ChatMessageDetails> chatMessageDetails;
  GotChatDetails({required this.chatMessageDetails});
}
