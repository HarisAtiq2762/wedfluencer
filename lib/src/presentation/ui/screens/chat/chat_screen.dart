import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/models/chat/charResponseData.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../../../models/chat/chatValue.dart';
import '../../../bloc/chat/chat_bloc.dart';
import '../../config/dateFormatter.dart';
import '../../config/helper.dart';
import '../../templates/chat_title.dart';
import '../../templates/khairyat_appbar.dart';
import 'message_screen.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  ChatHomePageState createState() => ChatHomePageState();
}

class ChatHomePageState extends State<ChatHomePage> {
  final searchController = TextEditingController();
  String searchText = '';
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  List<ChatValue> chats = [];

  Widget getExpandedWidget(
          {required List<ChatValue> chats, required int index}) =>
      Padding(
          padding: const EdgeInsets.only(left: 14),
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int j = 0; j < chats[index].chatrooms.length; j++)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<ChatBloc>(context).add(GetChatDetails(
                            id: chats[index]
                                .chatrooms[j]
                                .chat
                                .first
                                .chatRoomId));
                        Navigator.of(context).push(
                          WedfluencerHelper.createRoute(
                            page: ChatScreen(
                                chatMessageDetails: const [],
                                chatId: chats[index]
                                    .chatrooms[j]
                                    .chat
                                    .first
                                    .chatRoomId,
                                isOnline: true,
                                userId:
                                    chats[index].chatrooms.first.contactUserId,
                                imageUrl: '',
                                proposal: chats[index].proposal.title,
                                person: chats[index]
                                    .chatrooms
                                    .first
                                    .contactUsername),
                          ),
                        );
                      },
                      child: WedfluencerChatTitle.chatTitle(
                        isOnline: false,
                        title:
                            '${chats[index].chatrooms[j].contactFirstName} ${chats[index].chatrooms[j].contactLastName}',
                        subtitle: chats[index].chatrooms[j].chat.last.message,
                        imageUrl: chats[index].chatrooms[j].contactProfilePic,
                        date: chatTimeFormat.format(
                            chats[index].chatrooms[j].chat.last.createdAt),
                        unread:
                            chats[index].chatrooms[j].unreadCount.toString(),
                      ),
                    ),
                  ),
              ],
            ),
          ));

  Widget getExpandableChatTitle(
          {required ChatData chatData,
          required List<ChatValue> chatValue,
          required int index}) =>
      WedfluencerChatTitle.chatTitle(
        isOnline: chatData.activeUser
                .contains(chatValue[index].chatrooms.first.contactUserId)
            ? true
            : false,
        title: chatValue[index].proposal.title,
        date: chatTimeFormat
            .format(chatValue[index].chatrooms.first.chat.first.createdAt),
        unread: chatValue[index].chatrooms.first.unreadCount.toString(),
        subtitle: chatValue[index].chatrooms.first.chat.first.message,
        imageUrl: '',
      );

  void _insertChatsSequentially(List<ChatValue> chats) async {
    for (int i = 0; i < chats.length; i++) {
      await Future.delayed(
          const Duration(milliseconds: 10)); // delay between animations
      listKey.currentState
          ?.insertItem(i, duration: const Duration(milliseconds: 400));
    }
  }

  @override
  Widget build(BuildContext context) {
    DI.i<ChatBloc>().add(GetChats());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WedfluencerAppbar.generalAppbar(
        showBackButton: false,
        context: context,
        title: 'Messages',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return SizedBox(
                height: ScreenConfig.screenSizeHeight,
                child: const Center(child: CircularProgressIndicator()),
              );
            } else if (state is ChatError) {
              return Text(state.error);
            } else if (state is GotUserChats) {
              final chats = state.chatData.chats!.entries
                  .map((entry) => entry.value)
                  .toList();
              // Add items to the list after the first build
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _insertChatsSequentially(chats);
              });
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  WedfluencerDividers.transparentDivider(),
                  WedfluencerTextFields.iconTextField(
                    controller: searchController,
                    showIcon: true,
                    iconData: Icons.search,
                    hint: "search contacts",
                  ),
                  WedfluencerDividers.transparentDivider(),
                  Expanded(
                    child: AnimatedList(
                        key: listKey,
                        initialItemCount: 0,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index, animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-1, 0),
                              end: const Offset(0, 0),
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            ),
                            child: ExpandablePanel(
                              header: getExpandableChatTitle(
                                chatData: state.chatData,
                                chatValue: chats,
                                index: index,
                              ),
                              collapsed: const SizedBox(),
                              expanded:
                                  getExpandedWidget(chats: chats, index: index),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: ScreenConfig.screenSizeHeight * 0.1),
                ],
              );
            }
            return SizedBox(
              height: ScreenConfig.screenSizeHeight,
              child: Center(
                child: Text('No chats found',
                    style: ScreenConfig.theme.textTheme.bodySmall),
              ),
            );
          },
        ),
      ),
    );
  }
}
