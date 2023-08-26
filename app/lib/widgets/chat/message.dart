import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thud/models/chat.dart';
import 'package:thud/models/thudstate.dart';
import 'package:thud/widgets/profile_picture.dart';





class MessageTile extends StatelessWidget {
  final Message message;
  const MessageTile(this.message, {super.key});

  @override build(BuildContext context) {
    var thudState = context.read<ThudState>();
    var ownMessage = message.sender == thudState.activeUser!.id;
    var themeColor = Theme.of(context).colorScheme.primaryContainer;
    var myColor = Color.fromRGBO(
      themeColor.red,
      themeColor.green,
      themeColor.blue,
      ownMessage ? themeColor.alpha / 255 : 0.3,
    );

    var timestampWidget = Text(DateFormat('HH:mm').format(message.timestamp));
    return Container(
      margin: const EdgeInsets.all(4),
      alignment: ownMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Row(
          mainAxisAlignment: ownMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            ownMessage ? timestampWidget : const SizedBox(),
            const SizedBox(width: 4),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: myColor,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Text(message.message),
              ),
            ),
            const SizedBox(width: 4),
            ownMessage ? const SizedBox() : timestampWidget,
          ]
        )
      ),
    );
  }

}



class ChatScreen extends StatefulWidget {

  final ChatProvider chat;
  const ChatScreen(this.chat, {super.key});

  @override createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override build(BuildContext context) {
    var thudState = context.read<ThudState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back)
        ),
        title: Row(
          children: [
            ProfilePicture(widget.chat.user, size: 16),
            const SizedBox(width: 8),
            Username(widget.chat.user)
          ],
        )
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (_, chat, __) => CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => MessageTile(chat.messages[index]),
                      childCount: chat.messages.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      isDense: true,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (_messageController.text.isEmpty) {
                      return;
                    }
                    thudState.sendMessage(widget.chat.user.id, _messageController.text);
                    _messageController.clear();
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 100);
                  },
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}