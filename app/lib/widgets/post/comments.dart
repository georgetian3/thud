import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thud/models/thudstate.dart';
import 'package:thud/widgets/profile_picture.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  const CommentTile(this.comment, {super.key});

  @override build(BuildContext context) {
    var thudState = context.read<ThudState>();
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: FutureBuilder(
        future: thudState.getUser(comment.creator),
        builder:(context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const SizedBox();
          }
          var creator = snapshot.data!;

          return ListTile(
            leading: ProfilePicture(creator),
            trailing: Text(DateFormat('MM-dd HH:mm').format(comment.dateCreated)),
            title: Username(creator),
            subtitle: Text(comment.content),
          );
        }
      ),
    );
  }
}

class CommentList extends StatelessWidget {

  final List<Comment> comments;
  const CommentList(this.comments, {super.key});


  @override build(BuildContext context) {
    return Column(
      children: [
        for (final comment in comments)
          CommentTile(comment)
      ],
    );
  }




}