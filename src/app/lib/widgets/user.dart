import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';

import 'package:thud/langs/localizations.dart';
import 'package:thud/models/chat.dart';
import 'package:thud/models/thudstate.dart';
import 'package:thud/models/user.dart';
import 'package:thud/widgets/chat/message.dart';
import 'package:thud/widgets/post/post_summary.dart';
import 'package:thud/widgets/profile_picture.dart';
import 'package:thud/widgets/quill.dart';


class UserTabs extends StatefulWidget {
  final UserProvider user;
  const UserTabs(this.user, {super.key});
  @override createState() => _UserTabs();
}

class _UserTabs extends State<UserTabs> with TickerProviderStateMixin {

  static const tabs = [
    'posts',
    'comments',
    'likes',
    'saves',
    'following',
    'followers',
    'blocking',
  ];

  late TabController _tabController;

  @override initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override build(BuildContext context) {
    final thudState = context.read<ThudState>();
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            for (final tab in tabs) 
              Tab(text: tr(context, tab))
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              for (final posts in [widget.user.posts, widget.user.comments, widget.user.liked, widget.user.saved])
              ListView(
                children: [
                    for (final post in posts)
                      FutureBuilder(
                        future: thudState.getPost(post),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.data == null) {
                            return const SizedBox();
                          }
                          return PostSummary(snapshot.data!);
                        },
                      ),
                ],
              ),
              for (final users in [widget.user.followees, widget.user.followers, widget.user.blocking])
              ListView(
                children: [
                    for (final user in users)
                      FutureBuilder(
                        future: thudState.getUser(user),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.data == null) {
                            return const SizedBox();
                          }
                          return ListTile(
                            leading: ProfilePicture(snapshot.data!),
                            title: Username(snapshot.data!)
                          );
                        },
                      ),
                ],
              ),
            ],
          ),
        ),
      ],
    );


  }


}


class UserActions extends StatefulWidget {
  final UserProvider user;
  const UserActions(this.user, {super.key});
  @override createState() => _UserActions();
}

class _UserActions extends State<UserActions> {

  @override build(BuildContext context) {
    var thudState = context.read<ThudState>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            var chat = await thudState.getChat(id: widget.user.id);
            if (chat == null) {return;}
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider<ChatProvider>.value(
                  value: chat,
                  child: Consumer<ChatProvider>(
                    builder: (_, chat, __) => ChatScreen(chat),
                  ),
                ),
              ),
            );
          },
          icon: const Icon(Icons.chat),
          label: Text(tr(context, 'chat')),
        ),

        thudState.follows(widget.user.id) ?
        ElevatedButton.icon(
          onPressed: () async => await thudState.unfollow(widget.user.id),
          icon: const Icon(Icons.person_add),
          label: Text(tr(context, 'unfollow')),
        ) :
        ElevatedButton.icon(
          onPressed: () async => await thudState.follow(widget.user.id),
          icon: const Icon(Icons.person_add),
          label: Text(tr(context, 'follow')),
        ),

        thudState.blocks(widget.user.id) ?
        ElevatedButton.icon(
          onPressed: () async => await thudState.unblock(widget.user.id),
          icon: const Icon(Icons.block),
          label: Text(tr(context, 'unblock')),
        ) :
        ElevatedButton.icon(
          onPressed: () async => await thudState.block(widget.user.id),
          icon: const Icon(Icons.block),
          label: Text(tr(context, 'block')),
        ),
      ],
    );


  }

}

void changeUsernameDialog(BuildContext context) {
  String newUsername = '';
  String message = '';
  Color messageColor = Colors.transparent;
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(tr(context, 'changeUsername')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => setState(() => newUsername = value),
                decoration: InputDecoration(labelText: tr(context, 'newUsername')),
              ),
              const SizedBox(height: 16),
              Text(message, style: TextStyle(color: messageColor)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                setState(() => message = '');
                var success = await context.read<ThudState>().changeUsername(newUsername);
                setState(() {
                  if (success) {
                    message = tr(context, 'usernameChangeSuccess');
                    messageColor = Theme.of(context).colorScheme.primary;
                  } else {
                    message = tr(context, 'usernameChangeFailed');
                    messageColor = Theme.of(context).colorScheme.error;
                  }
                });
              },
              child: Text(tr(context, 'done')),
            )
          ],
        ),
      );
    },
  );
}


class UserInfoHeader extends StatefulWidget {
  final UserProvider user;
  const UserInfoHeader(this.user, {super.key});
  @override createState() => _UserInfoHeader();
}

class _UserInfoHeader extends State<UserInfoHeader> {

  late quill.QuillController _bioController;
  var _editBio = false;

  @override build(BuildContext context) {
    final thudState = context.read<ThudState>();
    _bioController = quill.QuillController(
      document: quill.Document.fromJson(json.decode(widget.user.bio!)),
      selection: const TextSelection.collapsed(offset: 0),
    );
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProfilePicture(
              widget.user,
              size: 64,
              onTap: () {
                if (widget.user.id == thudState.activeUser!.id) {
                  changeProfilePicture(context);
                }
              },
            ),
            const SizedBox(height: 8),
            Username(
              widget.user,
              onTap: () {
                if (widget.user.id == thudState.activeUser!.id) {
                  changeUsernameDialog(context);
                }
              },
              textStyle: Theme.of(context).textTheme.titleLarge,
            ),
            if (widget.user != thudState.activeUser!)
              UserActions(widget.user),
            const SizedBox(height: 4),
            const Divider(),
            Row(
              children: [
                Text(
                  tr(context, 'bio'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (widget.user == thudState.activeUser)
                  _editBio ?
                  IconButton(
                    onPressed: () async {
                      await thudState.changeBio(json.encode(_bioController.document.toDelta().toJson()));
                      setState(() => _editBio = false);
                    },
                    icon: const Icon(Icons.done),
                  ) :
                  IconButton(
                    onPressed: () => setState(() => _editBio = true),
                    icon: const Icon(Icons.edit),
                  ),
              ],
            ),
            Quill(_bioController, !_editBio),
            const Divider(),
          ]
        ),
      ),
    );
  }
}


Future<bool> changeProfilePicture(BuildContext context) async {
  final media = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (media == null) {
    return false;
  }
  // ignore: use_build_context_synchronously
  bool success = await context.read<ThudState>().changeProfilePicture(media);
  return success;
}


class UserInfo extends StatefulWidget {
  final UserProvider user;
  const UserInfo(this.user, {super.key});
  @override createState() => _UserInfo();
}

class _UserInfo extends State<UserInfo> {


  @override build(BuildContext context) {
    
    var thudState = context.read<ThudState>();
    return RefreshIndicator(
      onRefresh: () async => await thudState.getUser(widget.user.id, refresh: true),
      notificationPredicate: (notification) {
        return notification.depth == 2;
      },

      child: NestedScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          UserInfoHeader(widget.user)
        ],
        body: UserTabs(widget.user),
      ),
    );
  }
}


class UserScreen extends StatelessWidget {
  final UserProvider user;
  const UserScreen(this.user, {super.key});

  @override build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(tr(context, 'user')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: UserInfo(user),
      )
    );
  }
}


class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  @override build(BuildContext context) {
    var thudState = context.read<ThudState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, 'me'))
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ChangeNotifierProvider.value(
          value: thudState.activeUser,
          child: Consumer<UserProvider>(
            builder: (_, userProvider, __) => UserInfo(userProvider),
          ),
        ),
      ),
    );
  }
}