import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/config/helper.dart';
import 'package:wedfluencer/src/presentation/ui/screens/chat/message_screen.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dividers.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

import '../../templates/chat_title.dart';
import '../../templates/khairyat_appbar.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  String selectedPerson = 'Person 1';
  final searchController = TextEditingController();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WedfluencerAppbar.generalAppbar(
        showBackButton: false,
        context: context,
        title: 'Chats',
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
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
              ExpandablePanel(
                header: WedfluencerChatTitle.chatTitle(
                    title: 'Groom', subtitle: 'Hello groom'),
                collapsed: const SizedBox(),
                expanded: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Column(
                    children: [
                      WedfluencerDividers.transparentDivider(),
                      InkWell(
                        onTap: () {
                          WedfluencerHelper.createRoute(
                              page: ChatScreen(person: 'Bride'));
                        },
                        child: WedfluencerChatTitle.chatTitle(
                            title: 'Bride', subtitle: 'Hello bride'),
                      ),
                      WedfluencerDividers.transparentDivider(),
                      WedfluencerChatTitle.chatTitle(
                          title: 'Jack Wed', subtitle: 'Hello Jack'),
                    ],
                  ),
                ),
                // tapHeaderToExpand: true,
                // hasIcon: true,
              ),
              WedfluencerDividers.generalDivider(),
              ExpandablePanel(
                header: WedfluencerChatTitle.chatTitle(
                    title: 'Haris Wedding', subtitle: 'Hello haris'),
                collapsed: const SizedBox(),
                expanded: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Column(
                    children: [
                      WedfluencerDividers.transparentDivider(),
                      WedfluencerChatTitle.chatTitle(
                          title: 'Bride', subtitle: 'Hello bride'),
                      WedfluencerDividers.transparentDivider(),
                      WedfluencerChatTitle.chatTitle(
                          title: 'Jack Wed', subtitle: 'Hello Jack'),
                      WedfluencerDividers.transparentDivider(),
                      WedfluencerChatTitle.chatTitle(
                          title: 'Groom', subtitle: 'Hello groom'),
                      WedfluencerDividers.transparentDivider(),
                      WedfluencerChatTitle.chatTitle(
                          title: 'Groom', subtitle: 'Hello groom'),
                    ],
                  ),
                ),
                // tapHeaderToExpand: true,
                // hasIcon: true,
              ),
              WedfluencerDividers.generalDivider(),
              ExpandablePanel(
                header: WedfluencerChatTitle.chatTitle(
                    title: 'Groom', subtitle: 'Hello groom'),
                collapsed: const SizedBox(),
                expanded: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Column(
                    children: [
                      WedfluencerDividers.transparentDivider(),
                      WedfluencerChatTitle.chatTitle(
                          title: 'Bride', subtitle: 'Hello bride'),
                      WedfluencerDividers.transparentDivider(),
                      WedfluencerChatTitle.chatTitle(
                          title: 'Jack Wed', subtitle: 'Hello Jack'),
                    ],
                  ),
                ),
                // tapHeaderToExpand: true,
                // hasIcon: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
