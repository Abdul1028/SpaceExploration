import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class SpaceBotPage extends StatefulWidget {
  const SpaceBotPage({Key? key}) : super(key: key);

  @override
  _SpaceBotPageState createState() => _SpaceBotPageState();
}

class _SpaceBotPageState extends State<SpaceBotPage> {
  final Gemini gemini = Gemini.instance;
  ChatUser currentUser = ChatUser(id: "0", firstName: "Space Explorer");
  ChatUser geminiUser = ChatUser(
      id: "1", firstName: "Space Bot", profileImage: "assets/space-bot-pf.png");

  List<ChatMessage> messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFF171717), body: _chatUI());
  }

  Widget _chatUI() {
    return DashChat(
      currentUser: currentUser,
      onSend: callGemini,
      messages: messages,
      inputOptions: InputOptions(trailing: [
        IconButton(
          onPressed: _sendMediaMessage,
          icon: Icon(
            Icons.image,
            color: Color(0x799E86FF),
          ),
        )
      ]),
    );
  }

  void callGemini(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    try {
      String question = chatMessage.text;
      List<Uint8List>? images;

      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [File(chatMessage.medias!.first.url).readAsBytesSync()];
      }
      gemini
          .streamGenerateContent(
        question,
        images: images,
      )
          .listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous${current.text}") ??
              "";
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: response);

          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _sendMediaMessage() async {
    print("called");
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      ChatMessage message =
          ChatMessage(user: currentUser, createdAt: DateTime.now(), medias: [
        ChatMedia(url: file.path, fileName: file.name, type: MediaType.image)
      ]);
      callGemini(message);
    }
  }
}
