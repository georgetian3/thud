import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thud/models/thudstate.dart';
import 'package:thud/widgets/profile_picture.dart';

class PostHeader extends StatelessWidget {
  final Post post;
  const PostHeader(this.post, {super.key});

  @override build(BuildContext context) {
    var thudState = context.read<ThudState>();
    return FutureBuilder(
      future: thudState.getUser(post.creator),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox();
        }
        var creator = snapshot.data!;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfilePicture(creator),
                const SizedBox(width: 4),
                Expanded(child: Username(creator)),
                Text(DateFormat('yyyy-MM-dd kk:mm').format(post.dateCreated))
              ],
            ),
          ],
        );
      }
    );
    
  }
}