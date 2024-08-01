import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/models/chat/charResponseData.dart';
import 'package:wedfluencer/src/models/chat/vendorChat.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../../bloc/chat/chat_bloc.dart';
import '../../config/dateFormatter.dart';
import '../../config/helper.dart';
import '../../templates/chat_title.dart';
import '../../templates/khairyat_appbar.dart';
import 'message_screen.dart';

class VendorChatHomePage extends StatefulWidget {
  const VendorChatHomePage({super.key});

  @override
  VendorChatHomePageState createState() => VendorChatHomePageState();
}

class VendorChatHomePageState extends State<VendorChatHomePage> {
  final searchController = TextEditingController();
  String searchText = '';

  Widget getExpandedWidget(
          {required List<VendorChat> chats, required int index}) =>
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
                              userId: chats[index].contactUserId,
                              imageUrl: '',
                              proposal:
                                  chats[index].chatrooms[j].proposal.title,
                              person: chats[index].contactUsername,
                            ),
                          ),
                        );
                      },
                      child: WedfluencerChatTitle.chatTitle(
                        isOnline: false,
                        title: chats[index].chatrooms[j].proposal.title,
                        subtitle: chats[index].chatrooms[j].chat.last.message,
                        imageUrl: '',
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
          {required VendorChatData data,
          required List<VendorChat> chats,
          required int index}) =>
      WedfluencerChatTitle.chatTitle(
        isOnline: data.activeUser.contains(chats[index].users.first.id)
            ? true
            : false,
        title: chats[index].users.last.firstname +
            chats[index].users.last.lastname,
        date: chatTimeFormat
            .format(chats[index].chatrooms.first.chat.first.createdAt),
        unread: chats[index].chatrooms.first.unreadCount.toString(),
        subtitle: chats[index].chatrooms.first.chat.first.message,
        imageUrl: chats[index].users.last.profilePic.url,
      );

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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
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
                } else if (state is GotVendorChats) {
                  final chats = state.chatData.chats!.entries
                      .map((entry) => entry.value)
                      .toList();
                  return Column(
                    mainAxisSize: MainAxisSize.max,
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
                      for (int i = 0; i < chats.length; i++)
                        Column(
                          children: [
                            ExpandablePanel(
                              header: getExpandableChatTitle(
                                  data: state.chatData, chats: chats, index: i),
                              collapsed: const SizedBox(),
                              expanded:
                                  getExpandedWidget(chats: chats, index: i),
                            ),
                            WedfluencerDividers.generalDivider(),
                          ],
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
        ),
      ),
    );
  }
}
