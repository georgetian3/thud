import 'package:flutter/material.dart';
import 'package:thud/models/thudstate.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'dart:convert';

import 'package:thud/widgets/quill.dart';

class PostContent extends StatelessWidget {

  final Post post;
  final bool summary;
  const PostContent(this.post, this.summary, {super.key});

  @override
  Widget build(BuildContext context) {
    if (post.content.isEmpty || post.content == '[{"insert":"\\n"}]') {
      return const SizedBox();
    }

    return Quill(
      quill.QuillController(
        document: quill.Document.fromJson(json.decode(post.content)),
        selection: const TextSelection.collapsed(offset: 0),
      ),
      true,
    );
    // return quill.QuillEditor(
    //   controller: quill.QuillController(
    //     document: quill.Document.fromJson(json.decode(post.content)),
    //     selection: const TextSelection.collapsed(offset: 0),
    //   ),
    //   scrollController: ScrollController(),
    //   focusNode: FocusNode(),
    //   scrollable: true,
    //   expands: false,
    //   padding: const EdgeInsets.all(8),
    //   readOnly: true,
    //   autoFocus: false,
    //   showCursor: false,
    // );

  }

}