import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
  // Controllers
  final TextEditingController searchController = TextEditingController();

  // Global key for the animated list
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  // State variables
  String searchText = '';
  List<ChatValue> chats = [];
  List<ChatValue> filteredChats = [];

  @override
  void initState() {
    super.initState();
    // Fetch chats on initialization
    DI.i<ChatBloc>().add(GetChats());

    // Add listener to search controller
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  // Function to handle search text change
  void _onSearchChanged() {
    setState(() {
      searchText = searchController.text;
      // Filter chats based on search text
      List<ChatValue> newFilteredChats = chats.where((chat) {
        return chat.proposal.title
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            chat.chatrooms.any((room) =>
                '${room.contactFirstName} ${room.contactLastName}'
                    .toLowerCase()
                    .contains(searchText.toLowerCase()));
      }).toList();

      // Update the AnimatedList
      _updateAnimatedList(newFilteredChats);
    });
  }

  void _updateAnimatedList(List<ChatValue> newFilteredChats) {
    // Remove items that are no longer in the filtered list
    for (int i = filteredChats.length - 1; i >= 0; i--) {
      if (!newFilteredChats.contains(filteredChats[i])) {
        listKey.currentState?.removeItem(
          i,
          (context, animation) => SizeTransition(
              sizeFactor: animation, child: const SizedBox.shrink()),
          duration: const Duration(milliseconds: 300),
        );
      }
    }

    // Add new items to the filtered list
    for (int i = 0; i < newFilteredChats.length; i++) {
      if (!filteredChats.contains(newFilteredChats[i])) {
        listKey.currentState
            ?.insertItem(i, duration: const Duration(milliseconds: 300));
      }
    }

    filteredChats = newFilteredChats;
  }

  // Widget to build expanded chat rooms list
  Widget _buildExpandedChatRooms(
      {required List<ChatValue> chats, required int index}) {
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: SingleChildScrollView(
        child: Column(
          children: chats[index].chatrooms.map((chatroom) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: InkWell(
                onTap: () {
                  BlocProvider.of<ChatBloc>(context)
                      .add(GetChatDetails(id: chatroom.chat.first.chatRoomId));
                  Navigator.of(context).push(
                    WedfluencerHelper.createRoute(
                      page: ChatScreen(
                        chatMessageDetails: const [],
                        chatId: chatroom.chat.first.chatRoomId,
                        isOnline: true,
                        userId: chatroom.contactUserId,
                        imageUrl: '',
                        proposal: chats[index].proposal.title,
                        person: chatroom.contactUsername,
                      ),
                    ),
                  );
                },
                child: WedfluencerChatTitle.chatTitle(
                  isOnline: false,
                  title:
                      '${chatroom.contactFirstName} ${chatroom.contactLastName}',
                  subtitle: chatroom.chat.last.message,
                  imageUrl: chatroom.contactProfilePic,
                  date: chatTimeFormat.format(chatroom.chat.last.createdAt),
                  unread: chatroom.unreadCount.toString(),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Widget to build expandable chat title
  Widget _buildExpandableChatTitle(
      {required ChatData chatData,
      required List<ChatValue> chatValue,
      required int index}) {
    final chatRoom = chatValue[index].chatrooms.first;
    return WedfluencerChatTitle.chatTitle(
      isOnline: chatData.activeUser.contains(chatRoom.contactUserId),
      title: chatValue[index].proposal.title,
      date: chatTimeFormat.format(chatRoom.chat.first.createdAt),
      unread: chatRoom.unreadCount.toString(),
      subtitle: chatRoom.chat.first.message,
      imageUrl: '',
    );
  }

  // Function to insert chats into the list with animation
  void _insertChatsSequentially(List<ChatValue> chats) async {
    for (int i = 0; i < chats.length; i++) {
      await Future.delayed(
          const Duration(milliseconds: 10)); // Delay between animations
      listKey.currentState
          ?.insertItem(i, duration: const Duration(milliseconds: 400));
    }
  }

  @override
  Widget build(BuildContext context) {
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
            if (state is GotChatDetails || state is ChatLoading) {
              return SizedBox(
                height: ScreenConfig.screenSizeHeight,
                child: const Center(child: CircularProgressIndicator()),
              );
            } else if (state is ChatError) {
              return Text(state.error);
            } else if (state is GotUserChats) {
              chats = state.chatData.chats!.entries
                  .map((entry) => entry.value)
                  .toList();
              filteredChats = searchText.isNotEmpty ? filteredChats : chats;

              // Add items to the list after the first build
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _insertChatsSequentially(filteredChats);
              });
              if (chats.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animations/empty.json'),
                    Text('No chats found',
                        style: ScreenConfig.theme.textTheme.bodySmall),
                  ],
                );
              } else {
                return Column(
                  children: [
                    WedfluencerDividers.transparentDivider(),
                    WedfluencerTextFields.iconTextField(
                      controller: searchController,
                      showIcon: true,
                      iconData: Icons.search,
                      hint: "Search contacts",
                    ),
                    WedfluencerDividers.transparentDivider(),
                    Expanded(
                      child: AnimatedList(
                        key: listKey,
                        initialItemCount: filteredChats.length,
                        itemBuilder: (context, index, animation) {
                          if (index >= filteredChats.length) {
                            return const SizedBox();
                          }
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
                              header: _buildExpandableChatTitle(
                                chatData: state.chatData,
                                chatValue: filteredChats,
                                index: index,
                              ),
                              collapsed: const SizedBox(),
                              expanded: _buildExpandedChatRooms(
                                  chats: filteredChats, index: index),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: ScreenConfig.screenSizeHeight * 0.1),
                  ],
                );
              }
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Lottie.asset('assets/animations/empty.json'),
                Text('No chats found',
                    style: ScreenConfig.theme.textTheme.bodySmall),
              ],
            );
            // return Text('No chats found',
            //     style: ScreenConfig.theme.textTheme.bodySmall);
          },
        ),
      ),
    );
  }
}
