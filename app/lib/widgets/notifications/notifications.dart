import 'package:flutter/material.dart' hide Notification;
import 'package:thud/langs/localizations.dart';
import 'package:intl/intl.dart';
import 'package:thud/models/chat.dart';
import 'package:thud/models/post.dart';
import 'package:thud/models/thudstate.dart';
import 'package:thud/models/user.dart';
import 'package:thud/widgets/chat/message.dart';
import 'package:thud/widgets/post/post_details.dart';
import 'package:thud/widgets/user.dart';

class NotificationTile extends StatelessWidget {
  final Notification notification;
  const NotificationTile(this.notification, {super.key});
  @override
  build(BuildContext context) {
    var thudState = context.read<ThudState>();
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) =>
            thudState.deleteNotification(notification.id),
        child: ListTile(
          splashColor: Colors.transparent,
          onTap: () {
            // thudState.deleteNotification(notification.id);
            if ({'save', 'like', 'comment'}.contains(notification.type)) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FutureBuilder(
                          future: thudState.getPost(notification.content!,
                              refresh: true),
                          builder: (context, post) {
                            if (!post.hasData || post.data == null) {
                              return const SizedBox();
                            }
                            return ChangeNotifierProvider<PostProvider>.value(
                              value: post.data!,
                              child: Consumer<PostProvider>(
                                builder: (_, post, __) =>
                                    PostDetailScreen(post),
                              ),
                            );
                          })));
            } else if (notification.type == 'message') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FutureBuilder(
                          future: thudState.getChat(id: notification.sender),
                          builder: (context, chat) {
                            if (!chat.hasData || chat.data == null) {
                              return const SizedBox();
                            }
                            return ChangeNotifierProvider<ChatProvider>.value(
                              value: chat.data!,
                              child: Consumer<ChatProvider>(
                                builder: (_, chat, __) => ChatScreen(chat),
                              ),
                            );
                          })));
            } else if (notification.type == 'follow') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FutureBuilder(
                          future: thudState.getUser(notification.sender),
                          builder: (context, user) {
                            if (!user.hasData || user.data == null) {
                              return const SizedBox();
                            }
                            return ChangeNotifierProvider<UserProvider>.value(
                              value: user.data!,
                              child: Consumer<UserProvider>(
                                builder: (_, user, __) => UserScreen(user),
                              ),
                            );
                          })));
            }
          },
          title: FutureBuilder(
            future: thudState.notificationToString(notification),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const SizedBox();
              }
              return Text(snapshot.data!);
            },
          ),
          trailing: Text(
            DateFormat('MM-dd HH:mm').format(notification.timestamp),
          ),
        ));
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  build(BuildContext context) {
    var notifications = context.select<ThudState, List<Notification>>(
        (thudState) => thudState.notifications.values.toList());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            title: Text(tr(context, 'notifications')),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => NotificationTile(
                  notifications[notifications.length - index - 1]),
              childCount: notifications.length,
            ),
          ),
        ],
      ),
    );
  }
}
