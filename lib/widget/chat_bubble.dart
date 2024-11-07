import 'package:chat_app/models/chat_message_entity.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageEntity entity;
  final Alignment bubbleAlignment;

  ChatBubble({super.key, required this.bubbleAlignment, required this.entity});

  @override
  Widget build(BuildContext context) {
    bool isAuthor =
        entity.author.username == context.read<AuthService>().getUserName();
    return Align(
      alignment: bubbleAlignment,
      child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(
              color: isAuthor ? Theme.of(context).primaryColor : Colors.black87,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(entity.text,
                  style: const TextStyle(fontSize: 20, color: Colors.white)),
              if (entity.imageUrl != null)
                Image.network(
                  '${entity.imageUrl}',
                  height: 200,
                ),
            ],
          )),
    );
  }
}
