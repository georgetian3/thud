import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thud/models/chat.dart';
import 'package:thud/models/thudstate.dart';
import 'package:thud/langs/localizations.dart';

import 'package:intl/intl.dart';
import 'package:thud/models/user.dart';
import 'package:thud/widgets/chat/message.dart';
import 'package:thud/widgets/profile_picture.dart';


class ChatSummary extends StatelessWidget {
  const ChatSummary({super.key});
  @override build(BuildContext context) {
    var chat = context.watch<ChatProvider>();
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        splashColor: Colors.transparent,
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          ChangeNotifierProvider<ChatProvider>.value(
            value: chat,
            child: Consumer<ChatProvider>(
              builder: (_, chat, __) => ChatScreen(chat)
            ),
          ),
        )),
        leading: ProfilePicture(chat.user),
        title: Selector<UserProvider, String>(
          selector: (_, user) => user.username,
          builder: (context, username, child) => Text(chat.user.username),
        ),
        subtitle: Text(
          chat.messages.last.message,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          DateFormat('MM-dd HH:mm').format(chat.messages.last.timestamp),
        ),
      )
    );
  }
}

void newChatDialog(BuildContext context) {
  final thudState = context.read<ThudState>();
  final usernameController = TextEditingController();
  var errorMessage = '';
  int count = 0;
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder:(context, setState) => AlertDialog(
        title: Text(tr(context, 'newChat')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(label: Text(tr(context, 'username'))),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              )
            ),
          ]
        ),
        actions: [
          TextButton(
            onPressed: () async {
              var chat = await thudState.getChat(username: usernameController.text);
              print('count $count');
              if (chat == null) {
                setState(() => errorMessage = tr(context, 'userNotFound'));
                return;
              }
              print('count $count');
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChangeNotifierProvider<ChatProvider>.value(
                  value: chat,
                  child: Consumer<ChatProvider>(
                    builder: (_, chat, __) => ChatScreen(chat)
                  ),
                );
              }));
            },
            child: Text(tr(context, 'done'))
          ),
        ],
      ),
    ),
  );

}


class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});
  @override createState() => _ChatListScreen();
}

class _ChatListScreen extends State<ChatListScreen> {

  List<ChatProvider> _chatOrder = [];

  @override initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(
        const Duration(seconds: 2),
        (_) async {
          var thudState = Provider.of<ThudState>(context, listen: false);
          await thudState.getMessages();
          var chatOrder = thudState.getChatOrder();
          if (chatOrder != _chatOrder) {
            setState(() => _chatOrder = chatOrder);
          }
        }
      );
    });
  }
  @override build(BuildContext context) {
    var thudState = context.read<ThudState>();
    _chatOrder = thudState.getChatOrder();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            title: Text(tr(context, 'chats')),
            actions: [
              IconButton(
                onPressed: () => newChatDialog(context),
                icon: const Icon(Icons.add),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => MultiProvider(
                providers: [
                  ChangeNotifierProvider<ChatProvider>.value(value: _chatOrder[index]),
                  ChangeNotifierProvider<UserProvider>.value(value: _chatOrder[index].user)
                ],
                child: Consumer2<ChatProvider, UserProvider>(
                  builder: (context, chat, user, child) => const ChatSummary(),
                )
              ),
              childCount: _chatOrder.length,
            ),
          ),
        ],
      ),
    );
  }
}