import 'package:flutter/material.dart';
import 'package:gen_ai_trial/features/chat/models/message.dart';

class ChatScreen extends StatefulWidget {
  final List<Message> chatHistory;
  const ChatScreen({
    required this.chatHistory,
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return widget.chatHistory.isEmpty
        ? const Center(
            child: Text('Send in your first prompt to get started'),
          )
        : ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: widget.chatHistory.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: widget.chatHistory[index].fromUser
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.sizeOf(context).width * .8,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: widget.chatHistory[index].fromUser
                            ? Colors.green
                            : Colors.blue),
                    child: SelectableText(
                      widget.chatHistory[index].text,
                    ),
                  ),
                ],
              );
            },
          );
  }
}
