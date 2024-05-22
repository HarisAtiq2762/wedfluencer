import 'package:flutter/material.dart';
import 'package:wedfluencer/src/infrastructure/screen_size_config/screen_size_config.dart';
import 'package:wedfluencer/src/presentation/ui/screens/chat/message_screen.dart';

class ChatDropdown extends StatefulWidget {
  String selectedPerson;
  ChatDropdown({super.key, required this.selectedPerson});

  @override
  State<ChatDropdown> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ChatDropdown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenConfig.screenSizeHeight * 0.5,
      child: DropdownButton<String>(
        isExpanded: true,
        hint: const Text('Select Category'),
        value: widget.selectedPerson,
        onChanged: (newValue) {
          setState(() {
            widget.selectedPerson = newValue!;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  person: widget.selectedPerson,
                  proposal: '',
                  isOnline: false,
                  imageUrl: '',
                ),
              ),
            );
          });
        },
        items: <String>[
          'Person 1',
          'Person 2',
          'Person 3',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: ListTile(
              leading: CircleAvatar(
                // Left side avatar
                child: Text(value[
                    0]), // Display the first character of the person's name as the avatar
              ),
              title: Text(value), // Centered person's name
              subtitle: const Text(
                  'Last message here'), // Message text below the person's name
              trailing: const Text(
                  'Today'), // Date or time of the message on the right side
            ),
          );
        }).toList(),
      ),
    );
  }
}
