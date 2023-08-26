import 'package:flutter/material.dart';


class TagList extends StatefulWidget {
  final List<String> tags;
  final bool deletable;
  const TagList(this.tags, {this.deletable = false, super.key});
  @override createState() => _TagList();
}

class _TagList extends State<TagList> {
  @override build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final tag in widget.tags)
            Padding(
              padding: const EdgeInsets.all(2),
              child: InputChip(
                labelPadding: const EdgeInsets.all(0),
                label: Text('#$tag'),
                labelStyle: TextStyle(
                  color: themeColor.primary
                ),
                onDeleted: widget.deletable ? () => setState(() => widget.tags.remove(tag)) : null,
              ),
            )
        ],
      ),
    );
  }
}