// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:thud/langs/localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:thud/models/thudstate.dart';
import 'package:thud/widgets/post/carousel.dart';
import 'package:thud/widgets/post/tags.dart';
import 'package:thud/widgets/quill.dart';
import 'package:thud/widgets/utils.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});
  @override createState() => _CreatePostScreen();
}

class _CreatePostScreen extends State<CreatePostScreen> {
  _CreatePostScreen();

  Future<void> chooseMedia(ImageSource imageSource, bool image) async {
    final picker = ImagePicker();
    final XFile? media = image
      ? await picker.pickImage(source: imageSource)
      : await picker.pickVideo(source: imageSource);
    if (media != null) {
      print('adding media');
      setState(() => _media.add(media));
    }
  }

  void chooseMediaType(BuildContext context) {

    var options = [
      ['choosePhoto', ImageSource.gallery, true],
      ['takePhoto', ImageSource.camera, true],
      ['chooseVideo', ImageSource.gallery, false],
      ['takeVideo', ImageSource.camera, false],
    ];
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (List option in options)
              ListTile(
                title: Text(tr(context, option[0])),
                onTap: () => chooseMedia(option[1], option[2]),
              ),
          ],
        ),
      )
    );

  }

  final _controller = quill.QuillController.basic();

  String _title = '';
  bool _uploadLocation = false;
  final _location = <String, double>{
    'latitude': 0,
    'longitude': 0,
  };
  String _locationString = '';

  final _media = <XFile>[];
  final _tags = <String>[];
  final _tagController = TextEditingController();



  void uploadLocationChecked(BuildContext context, bool? value) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'enableLocationServices')), behavior: SnackBarBehavior.floating),
      );
      return;
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr(context, 'giveLocationPermission')), behavior: SnackBarBehavior.floating),
        );
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr(context, 'giveLocationPermission')), behavior: SnackBarBehavior.floating),
      );
      return;
    } 

    Position? position;
    try {
      position = await showLoading(context, Geolocator.getCurrentPosition(timeLimit: const Duration(seconds: 5)), text: tr(context, 'gettingLocation'));
    } on TimeoutException {
      Navigator.pop(context);
      position = await showLoading(context, Geolocator.getLastKnownPosition(), text: tr(context, 'gettingLocation'));
    }

    if (position == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot get location - check GPS'), behavior: SnackBarBehavior.floating),
      );
      _locationString = tr(context, 'notUploadingLocation');
      return;
    }


    _location['latitude'] = position.latitude;
    _location['longitude'] = position.longitude;

    setState(() {
      _uploadLocation = value!;
      _locationString = _uploadLocation
        ? '${position!.latitude}, ${position.longitude}'
        : tr(context, 'notUploadingLocation');
    });

  }

  Future<void> _createPostDone(ThudState thudState) async {
    print('createPostDone clicked');
    print('title: $_title');

    final success = await showLoading(
      context,
      thudState.createPost(
        title: _title,
        tags: _tags,
        content: json.encode(_controller.document.toDelta().toJson()),
        location: _uploadLocation ? json.encode(_location) : null,
        media: _media,
      ),
      text: tr(context, 'creatingPost'),
    );
    // ignore: use_build_context_synchronously
    var message = 'Post creation failed';
    if (success) {
      Navigator.pop(context, true);
      message = 'Post created successfully';
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }


  @override build(BuildContext context) {
    var thudState = context.read<ThudState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(tr(context, 'createPost')),
            IconButton(
              onPressed: () async => await _createPostDone(thudState),
              icon: const Icon(Icons.done)
            ),
          ]
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              onChanged: (title) => setState(() => _title = title),
              decoration: InputDecoration(
                label: Text(tr(context, 'title')),
              ),
            ),
            const SizedBox(height: 8),
            TagList(_tags, deletable: true),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _tagController,
                    decoration: InputDecoration(label: Text(tr(context, 'tags'))),
                    onEditingComplete: () {
                      print('ediing complete');
                      setState(() => _tags.add(_tagController.text));
                      _tagController.clear();
                    },
                    onChanged: (value) {
                      if (value.endsWith(' ')) {
                        setState(() => _tags.add(_tagController.text.substring(0, _tagController.text.length - 1)));
                        _tagController.clear();
                      }
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                   setState(() => _tags.add(_tagController.text));
                   _tagController.clear();
                  },
                  icon: const Icon(Icons.add)
                ),
              ],

            ),
            const SizedBox(height: 8),
            const Divider(),

            Quill(_controller, false, placeholder: tr(context, 'enterPostContent')),

            const Divider(),

            CheckboxListTile(
              title: Text(tr(context, 'uploadLocation')),
              subtitle: Text(_locationString),
              value: _uploadLocation,
              onChanged: (value) => uploadLocationChecked(context, value),
              controlAffinity: ListTileControlAffinity.trailing,
            ),

            ListTile(
              title: Text(tr(context, 'uploadMedia')),
              trailing: IconButton(
                icon: const Icon(Icons.add_a_photo),
                onPressed: () => chooseMediaType(context),
              ),
            ),

            Carousel(media: _media),
          ],
        ),
      )
    );

  }

}