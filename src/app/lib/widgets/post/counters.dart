import 'package:flutter/material.dart';
import 'package:thud/langs/localizations.dart';
import 'package:thud/models/post.dart';
import 'package:thud/models/thudstate.dart';
import 'package:thud/models/typedefs.dart';
import 'package:thud/widgets/post/post_details.dart';
import 'package:thud/widgets/profile_picture.dart';



Future<void> showDialogList(BuildContext context, String title, Iterable<ID> userIds) async {
  final thudState = context.read<ThudState>();
  var users = [for (final userId in userIds) await thudState.getUser(userId)];
  // ignore: use_build_context_synchronously
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final user in users)
          ListTile(
            leading: ProfilePicture(user!),
            title: Username(user),
          )
        ],
      ),
    ),
  );
}


class Counters extends StatelessWidget {
  final PostProvider post;
  final Function()? onCommentClick;
  const Counters(this.post, {this.onCommentClick, super.key});

  @override build(BuildContext context) {

    var thudState = context.read<ThudState>();
    var primaryColor = Theme.of(context).colorScheme.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            GestureDetector(
              onLongPress: () async => await showDialogList(context, tr(context, 'likers'), post.likers),
              child: IconButton(
                onPressed: () async => thudState.liked(post.id) ? await thudState.unlike(post.id) : await thudState.like(post.id),
                icon: Icon(thudState.liked(post.id) ? Icons.thumb_up : Icons.thumb_up_outlined),
                color: primaryColor,
              ),
            ),
            Text(post.likers.length.toString()),
          ],
        ),
        
        Row(
          children: [
            IconButton(
              isSelected: false,
              onPressed: () {
                if (onCommentClick != null) {
                  onCommentClick!();
                  return;
                }
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider<PostProvider>.value(
                    value: post,
                    child: Consumer<PostProvider>(
                      builder: (_, post, __) => PostDetailScreen(post),
                    ),
                  ),
                ));
              },
              icon: const Icon(Icons.message_outlined),
              color: primaryColor,
            ),
            Text(post.comments.length.toString()),
          ]
        ),
        Row(
          children: [
            GestureDetector(
              onLongPress: () async => await showDialogList(context, tr(context, 'savers'), post.savers),
              child: IconButton(
                onPressed: () async => thudState.saved(post.id) ? await thudState.unsave(post.id) : await thudState.save(post.id),
                icon: Icon(thudState.saved(post.id) ? Icons.star : Icons.star_outline),
                color: primaryColor,
              ),
            ),
            Text(post.savers.length.toString()),
          ]
        ),
      ],
    );
  }
}