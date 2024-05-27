import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/models/chat/charResponseData.dart';
import 'package:wedfluencer/src/models/chat/chatMessageDetails.dart';

import '../../../infrastructure/resources/chat/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final repository = ChatRepository();

  ChatBloc() : super(ChatInitial()) {
    on<GetChats>((event, emit) async {
      emit(ChatLoading());
      try {
        final result = await repository.getUserChats();
        emit(GotUserChats(chatData: result));
      } catch (e) {
        emit(ChatError(error: e.toString()));
        emit(ChatInitial());
      }
    });

    on<GetChatDetails>((event, emit) async {
      emit(ChatLoading());
      try {
        await repository.markAsRead(id: event.id);
        final result = await repository.getChatDetails(id: event.id);
        emit(GotChatDetails(chatMessageDetails: result));
      } catch (e) {
        emit(ChatError(error: e.toString()));
        emit(ChatInitial());
      }
    });

    on<SendMessage>((event, emit) async {
      emit(ChatLoading());
      try {
        await repository.sendMessage(id: event.userId, message: event.message);
        emit(MessageSent());
      } catch (e) {
        emit(ChatError(error: e.toString()));
        emit(ChatInitial());
      }
    });
  }
}
