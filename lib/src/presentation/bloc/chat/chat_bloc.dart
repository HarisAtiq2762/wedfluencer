import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/auth_repository.dart';
import 'package:wedfluencer/src/infrastructure/domain/authentication/models/user_model.dart';
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
        VendorChatData vendorChatData;
        ChatData chatData;

        // DI.i<AuthRepository>().user?.role == UserRole.vendor
        //    ? await repository.getVendorChats()
        //    : await repository.getUserChats();
        if (DI.i<AuthRepository>().user?.role == UserRole.vendor) {
          vendorChatData = await repository.getVendorChats();
          emit(GotVendorChats(chatData: vendorChatData));
        } else if (DI.i<AuthRepository>().user?.role == UserRole.brideGroom) {
          chatData = await repository.getUserChats();
          emit(GotUserChats(chatData: chatData));
        }
      } catch (e) {
        emit(ChatError(error: e.toString()));
        emit(ChatInitial());
      }
    });

    on<GetChatDetails>((event, emit) async {
      // emit(ChatLoading());
      try {
        // await repository.markAsRead(id: event.id);
        final result = await repository.getChatDetails(id: event.id);
        emit(GotChatDetails(chatMessageDetails: result));
      } catch (e) {
        emit(ChatError(error: e.toString()));
        emit(ChatInitial());
      }
    });

    on<SendMessage>((event, emit) async {
      // emit(ChatLoading());
      try {
        await repository.sendMessage(id: event.userId, message: event.message);
        emit(GotChatDetails(chatMessageDetails: event.chatMessageDetails));
      } catch (e) {
        emit(ChatError(error: e.toString()));
        emit(ChatInitial());
      }
    });
  }
}
