import 'dart:convert';
import 'package:chat_app/models/chat_message_entity.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/widget/chat_bubble.dart';
import 'package:chat_app/widget/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessageEntity> _chatMessages = [];

  _loadMessages() async {
    final response = await rootBundle.loadString('assets/mock_messages.json');
    final List<dynamic> decodedResponse = jsonDecode(response) as List;
    final List<ChatMessageEntity> chatMessagesList =
        decodedResponse.map((listItem) {
      return ChatMessageEntity.fromJson(listItem);
    }).toList();
    setState(() {
      _chatMessages = chatMessagesList;
    });
  }

  void onMessageSent(ChatMessageEntity entity) {
    _chatMessages.add(entity);
    setState(() {});
  }

  @override
  void initState() {
    _loadMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final username = context.watch<AuthService>().getUserName();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hii $username!!",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await context.read<AuthService>().updateUser("New Name");
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () async {
                await context.read<AuthService>().logoutUser();
                Navigator.popAndPushNamed(context, '/');
                setState(() {});
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: _chatMessages.length,
            itemBuilder: (context, index) {
              return ChatBubble(
                bubbleAlignment: _chatMessages[index].author.username ==
                        context.read<AuthService>().getUserName()
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                entity: _chatMessages[index],
              );
            },
          )),
          ChatInput(
            onSubmit: onMessageSent,
          )
        ],
      ),
    );
  }
}
