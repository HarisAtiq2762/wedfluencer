// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  String? _selectedPerson;
  TextEditingController _searchController = TextEditingController();
  String? _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search Contacts',
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 118, 118, 118)),
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 154, 154, 154), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 255, 90, 189)),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                  });
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
                child: SizedBox(
                  height: 200, // Set the height of the dropdown menu
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text('Select Category'),
                    value: _selectedPerson,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPerson = newValue;
                        if (_selectedPerson != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(person: _selectedPerson!),
                            ),
                          );
                        }
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
                          subtitle: Text('Last message here'), // Message text below the person's name
                          trailing: Text('Today'), // Date or time of the message on the right side
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
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.person}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('Chatting with ${widget.person}'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message here',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Send message functionality
                    final message = _messageController.text;
                    if (message.isNotEmpty) {
                      // Send message
                      print('Message sent: $message');
                      // Clear text field
                      _messageController.clear();
                    }
                  },
                  child: Text('Send'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Attach file functionality
                    print('Attach file');
                  },
                  child: Text('Attach'),
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
