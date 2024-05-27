import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedfluencer/src/infrastructure/dependency_injection.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/ui/templates/khairyat_appbar.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../../../infrastructure/domain/authentication/auth_repository.dart';
import '../../../bloc/chat/chat_bloc.dart';

class ChatScreen extends StatefulWidget {
  final String person;
  final String chatId;
  final String proposal;
  final String imageUrl;
  final bool isOnline;
  final String userId;

  const ChatScreen(
      {super.key,
      required this.person,
      required this.isOnline,
      required this.proposal,
      required this.userId,
      required this.chatId,
      required this.imageUrl});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WedfluencerAppbar.generalAppbar(
          hasTitleAsWidget: true,
          titleWidget: Row(
            children: [
              widget.imageUrl != ''
                  ? Badge(
                      alignment: Alignment.bottomRight,
                      smallSize: 10,
                      backgroundColor:
                          widget.isOnline ? Colors.green : Colors.red,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.imageUrl),
                        backgroundColor: Colors.white,
                        radius: 26,
                      ),
                    )
                  : const CircleAvatar(
                      backgroundImage: AssetImage('assets/logos/logo.png'),
                      backgroundColor: Colors.white,
                      radius: 26,
                    ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: ScreenConfig.screenSizeWidth * 0.6,
                    child: Text(
                      widget.proposal,
                      overflow: TextOverflow.ellipsis,
                      style: ScreenConfig.theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    '@${widget.person}',
                    style: ScreenConfig.theme.textTheme.labelSmall,
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ],
          ),
          context: context,
          title: ''),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: ScreenConfig.screenSizeHeight * 0.86,
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is GotChatDetails) {
                    final messages = state.chatMessageDetails;
                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: messages[index].senderId ==
                                  DI.i<AuthRepository>().user!.userId
                              ? Alignment.centerRight
                              : Alignment
                                  .centerLeft, // Align messages to the right
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: messages[index].senderId ==
                                      DI.i<AuthRepository>().user!.userId
                                  ? ScreenConfig.theme.primaryColor
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Text(
                              messages[index].message,
                              style: ScreenConfig.theme.textTheme.bodySmall,
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file_outlined,
                      color: ScreenConfig.theme.primaryColor),
                  iconSize: 24.0,
                  onPressed: () {},
                ),
                WedfluencerTextFields.iconTextField(
                  width: ScreenConfig.screenSizeWidth * 0.72,
                  controller: _messageController,
                  showIcon: false,
                ),
                BlocListener<ChatBloc, ChatState>(
                  listener: (context, state) {
                    if (state is MessageSent) {
                      BlocProvider.of<ChatBloc>(context)
                          .add(GetChatDetails(id: widget.chatId));
                    }
                  },
                  child: IconButton(
                    icon: Icon(Icons.send,
                        color: ScreenConfig.theme.primaryColor),
                    iconSize: 24.0,
                    onPressed: () {
                      BlocProvider.of<ChatBloc>(context).add(SendMessage(
                          message: _messageController.text,
                          userId: widget.chatId));
                      _messageController.clear();
                    },
                  ),
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Stack(
            //     children: [
            //       Container(
            //           decoration: BoxDecoration(
            //             color: Colors.grey[200], // Light grey background color
            //             borderRadius: BorderRadius.circular(20.0),
            //           ),
            //           child:
            //           TextField(
            //             controller: _messageController,
            //             decoration: const InputDecoration(
            //               hintText: 'Type your message here',
            //               contentPadding: EdgeInsets.symmetric(
            //                   vertical: 10.0, horizontal: 48.0),
            //               // Adjust padding to avoid overlapping with buttons
            //               border: InputBorder.none, // Remove border
            //             ),
            //           ),
            //           ),
            //       Positioned(
            //         left: 0,
            //         top: 0,
            //         bottom: 0,
            //         child: IconButton(
            //           icon: const Icon(Icons.attach_file),
            //           onPressed: () {},
            //         ),
            //       ),
            //       Positioned(
            //         right: 0,
            //         top: 4,
            //         bottom: 4,
            //         child: Container(
            //           decoration: BoxDecoration(
            //             color: Colors.pink[100],
            //             borderRadius: BorderRadius.circular(20.0),
            //           ),
            //           child: IconButton(
            //             icon: const Icon(Icons.send, color: Colors.white),
            //             iconSize: 20.0,
            //             onPressed: () {},
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    DI.i<ChatBloc>().add(GetChats());
    super.dispose();
  }
}
