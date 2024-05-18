import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/screens/chat/message_screen.dart';
import 'package:wedfluencer/src/presentation/ui/templates/dropdown_chat.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

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
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 12.0, right: 12.0),
              child: WedfluencerTextFields.iconTextField(
                controller: searchController,
                showIcon: true,
                iconData: Icons.search,
                hint: "search contacts",
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
                  child: ChatDropdown(
                    selectedPerson: selectedPerson,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
