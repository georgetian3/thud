import 'package:flutter/material.dart';

class PostTitle extends StatelessWidget {

  final String title;
  final bool summary;
  const PostTitle(this.title, this.summary, {super.key});

  @override
  Widget build(BuildContext context) {
    if (title.isEmpty) {
      return const SizedBox();
    }
    return Text(
      title,
      maxLines: summary ? 2 : 999,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}