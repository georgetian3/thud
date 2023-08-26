import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class Quill extends StatelessWidget {

  final bool readOnly;
  final QuillController controller;
  final String placeholder;
  const Quill(
    this.controller,
    this.readOnly, {
    this.placeholder = 'Type here ...',
    super.key
  });


  @override build(BuildContext context) {
    return Column(
      children: [
        QuillEditor(
          controller: controller,
          scrollController: ScrollController(),
          focusNode: FocusNode(),
          scrollable: true,
          expands: false,
          padding: const EdgeInsets.all(8),
          showCursor: !readOnly,
          readOnly: readOnly,
          autoFocus: false,
          placeholder: readOnly ? '' : placeholder,
        ),
        if (!readOnly)
        QuillToolbar.basic(
          controller: controller,
          showFontFamily: false,
          showSubscript: false,
          showSuperscript: false,
        ),
      ],
    );

  }

}