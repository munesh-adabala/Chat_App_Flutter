import 'package:chat_app/models/chat_message_entity.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/widget/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatInput extends StatefulWidget {
  final Function(ChatMessageEntity) onSubmit;

  ChatInput({super.key, required this.onSubmit});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final chatMessageController = TextEditingController();

  String _imageUrl = '';

  Future<void> onSendMessage() async {
    String userNameFromCache = await context.read<AuthService>().getUserName();
    final chatMessage = ChatMessageEntity(
        id: "343",
        createdAt: DateTime.now().millisecondsSinceEpoch,
        text: chatMessageController.text,
        author: Author(username: userNameFromCache));
    if (_imageUrl.isNotEmpty) {
      chatMessage.imageUrl = _imageUrl;
    }
    widget.onSubmit(chatMessage);
    chatMessageController.clear();
    _imageUrl = '';
    setState(() {});
  }

  void onImageSelected(String url) {
    setState(() {
      _imageUrl = url;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.black,
                  context: context,
                  builder: (BuildContext buildContext) {
                    return ImagePickerWidget(onImageSelected: onImageSelected);
                  });
            },
            icon: const Icon(Icons.add),
            color: Colors.white,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: chatMessageController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 1,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      hintText: "Add Message",
                      border: InputBorder.none),
                  style: const TextStyle(color: Colors.white),
                ),
                if (_imageUrl.isNotEmpty) Image.network(_imageUrl, height: 50)
              ],
            ),
          ),
          IconButton(
            onPressed: onSendMessage,
            icon: const Icon(Icons.send),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
