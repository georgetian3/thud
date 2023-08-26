import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:thud/widgets/post/videoplayer.dart';
import 'dart:io';
import 'package:http/http.dart' as http;


enum MediaType {image, video, unknown}


Future<MediaType> getMediaType(dynamic media) async {
  String? mimeType = (media is XFile) ?
    lookupMimeType(media.path) : (media is String) ?
    (await http.head(Uri.parse(media))).headers['content-type'] : null;

  if (mimeType == null) {
    return MediaType.unknown;
  }
  if (mimeType.startsWith('image')) {
    return MediaType.image;
  }
  if (mimeType.startsWith('video')) {
    return MediaType.video;
  }

  return MediaType.unknown;
}


class Carousel extends StatefulWidget {
  final List<dynamic> media;
  final int initialIndex;
  const Carousel({
    this.media = const [],
    this.initialIndex = 0, 
    super.key
  });
  @override createState() => _Carousel();
}

class _Carousel extends State<Carousel> {

  int _current = 0;
  final CarouselController _controller = CarouselController();

  // @override initState() {
  //   super.initState();
  //   if (widget.initialIndex >= 0 && widget.initialIndex < widget.items.length) {
  //     _controller.jumpToPage(widget.initialIndex);
  //   } 
  // }


  @override initState() {
    super.initState();
  }

  @override build(BuildContext context) {
    if (widget.media.isEmpty) {
      return const SizedBox();
    }

    final List<Widget> widgets = [];
    for (final media in widget.media) {
      widgets.add(FutureBuilder(
        future: getMediaType(media),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          var mediaType = snapshot.data;
          if (mediaType == MediaType.unknown) {
            return const SizedBox();
          }

          return mediaType == MediaType.image
            ? InkWell(
              onTap: () async => showImageViewer(
                context, 
                (media is XFile) ? Image.file(File(media.path)).image : Image.network(media).image ,
                swipeDismissible: true,
                doubleTapZoomable: true,  
              ),
              child: (media is XFile) ? Image.file(File(media.path)) : Image.network(media),
            )
            : (media is XFile) ? Player(file: media) : Player(url: media);
        }
      ));
    }
    
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _controller,
          options: CarouselOptions(
            aspectRatio: 1,
            enableInfiniteScroll: false,
            viewportFraction: 1,
            onPageChanged: (index, reason) => setState(() => _current = index),
          ),
          itemCount: widgets.length,
          itemBuilder: (context, index, realIndex) => widgets[index],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < widgets.length; i++) 
              GestureDetector(
                onTap: () => _controller.animateToPage(i),
                child: Container(
                  alignment: Alignment.center,
                  width: 16, height: 16,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == i ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Text(
                    (i + 1).toString(),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              )
            ]
          ),
        ),
      ],
    );
  }
}