import 'package:flutter/material.dart';
import 'package:wedfluencer/src/presentation/ui/templates/textfields.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  String? selectedPerson; // Changed to nullable type
  final searchController = TextEditingController();
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
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
                child: SizedBox(
                  height: 200, // Set the height of the dropdown menu
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text('Select Category'),
                    value: selectedPerson,
                    onChanged: (newValue) {
                      setState(() {
                        selectedPerson = newValue!;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(person: selectedPerson!),
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
                            child: Text(value[0]), // Display the first character of the person's name as the avatar
                          ),
                          title: Text(value), // Centered person's name
                          subtitle: const Text('Last message here'), // Message text below the person's name
                          trailing: const Text('Today'), // Date or time of the message on the right side
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String person;

  const ChatScreen({Key? key, required this.person}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<String> messages = [
    'Hello!',
    'How are you?'
  ]; // Demo messages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              child: Text(widget.person[0]), // Display the first character of the person's name as the avatar
            ),
            const SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.person,
                  style: TextStyle(
                    color: Colors.grey[800], // Set the title color to dark grey
                  ),
                ),
                Text(
                  '@${widget.person}',
                  style: TextStyle(
                    color: Colors.grey[600], // Set the subtitle color
                    fontSize: 12.0, // Smaller font size for subtitle
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight, // Align messages to the right
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.pink[100],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Text(
                      messages[index],
                      style: const TextStyle(
                        fontSize: 14.0, // Smaller font size
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Light grey background color
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message here',
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 48.0), // Adjust padding to avoid overlapping with buttons
                      border: InputBorder.none, // Remove border
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () {
                      // Attach file functionality
                      print('Attach file');
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 4,
                  bottom: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.pink[100],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      iconSize: 20.0, // Make the icon smaller
                      onPressed: () {
                        // Send message functionality
                        final message = _messageController.text;
                        if (message.isNotEmpty) {
                          setState(() {
                            messages.add(message); // Add new message to the list
                          });
                          _messageController.clear(); // Clear text field
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
