import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thud/models/post.dart';
import 'package:thud/models/thudstate.dart';

import 'package:thud/widgets/post/carousel.dart';
import 'package:thud/widgets/post/counters.dart';
import 'package:thud/widgets/post/location_tile.dart';
import 'package:thud/widgets/post/post_content.dart';
import 'package:thud/widgets/post/post_header.dart';
import 'package:thud/widgets/post/post_title.dart';
import 'package:thud/widgets/post/tags.dart';

class PostWidgets extends StatelessWidget {
  final PostProvider post;
  final bool summary;
  const PostWidgets(this.post, this.summary, {super.key});

  @override build(BuildContext context) {

    double longitude = 0;
    double latitude = 0;
    if (post.location != null) {
      var location = json.decode(post.location!);
      longitude = location['longitude'];
      latitude = location['latitude'];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostHeader(post),
        const SizedBox(height: 8),
        if (post.title.isNotEmpty) ...[
          PostTitle(post.title, summary),
        ],
        if (post.tags.isNotEmpty) ...[
          TagList(post.tags),
        ],
        if (post.location != null) ...[
          LocationTile(longitude, latitude),
        ],
        if (post.content != '[{"insert":"\\n"}]') ...[
          const Divider(),
          PostContent(post, summary),
          const Divider(),
        ],
        Carousel(media: [for (final media in post.media) context.read<ThudState>().mediaIdToUrl(media)]),
        Counters(post, onCommentClick: summary ? null : () {}),
      ],
    );
  }

}
