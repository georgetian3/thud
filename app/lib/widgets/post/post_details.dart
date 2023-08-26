import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:intl/intl.dart';
import 'package:thud/models/post.dart';
import 'package:thud/models/thudstate.dart';
import 'package:thud/models/typedefs.dart';
import 'package:thud/widgets/post/comments.dart';
import 'package:thud/widgets/post/post_widgets.dart';
import 'package:thud/langs/localizations.dart';

import 'package:share_plus/share_plus.dart';


Future<void> createCommentDialog(BuildContext context, ID postId) async {
  String comment = '';
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(tr(context, 'createComment')),
        content: TextField(
          onChanged: (value) => setState(() => comment = value),
          maxLines: 5,
          decoration: InputDecoration(
            labelText: tr(context, 'comment'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              context.read<ThudState>().createComment(postId, comment);
              Navigator.pop(context);
            },
            child: Text(tr(context, 'done'))
          ),
        ],
      ),
    ),
  );


}


class PostDetailScreen extends StatelessWidget {
  final PostProvider post;
  const PostDetailScreen(this.post, {super.key});
  @override build(BuildContext context) {
    final thudState = context.read<ThudState>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async => createCommentDialog(context, post.id),
        child: const Icon(Icons.add_comment),
      ),
      body: RefreshIndicator(
        onRefresh: () => thudState.getPost(post.id, refresh: true),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              title: Text(tr(context, 'posts')),
              actions: [
                IconButton(
                  onPressed: () async {
                    final document = quill.Document.fromJson(json.decode(post.content));
                    final username = (await thudState.getUser(post.creator))?.username;
                    final dateTime = DateFormat('yyyy-MM-dd HH:mm').format(post.dateCreated);
                    final tags = post.tags.isEmpty ? '' : '#${post.tags.join(' #')}\n';
                    Share.share('${post.title}\n@$username $dateTime\n$tags${document.toPlainText()}');
                  },
                  icon: const Icon(Icons.share),
                ),
                IconButton(
                  onPressed: () async => createCommentDialog(context, post.id),
                  icon: const Icon(Icons.add_comment),
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostWidgets(post, false),
                    const Divider(),
                    CommentList(post.comments)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}