// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayer extends StatefulWidget {
//   const VideoPlayer({super.key});
//   @override createState() => _VideoPlayer();
// }

// class _VideoPlayer extends State<VideoPlayer> {
//   late VideoPlayerController _videoPlayerController1;
//   ChewieController? _chewieController;
//   int? bufferDelay;

//   @override
//   void initState() {
//     super.initState();
//     initializePlayer();
//   }

//   @override
//   void dispose() {
//     _videoPlayerController1.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }

//   List<String> srcs = [
//     "https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4",
//     "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
//     "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4"
//   ];

//   Future<void> initializePlayer() async {
//     _videoPlayerController1 =
//         VideoPlayerController.network(srcs[0]);
//     await Future.wait([
//       _videoPlayerController1.initialize(),
//     ]);
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController1,
//       autoPlay: false,
//       looping: false,
//     );
//     setState(() {});
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: _chewieController != null &&
//               _chewieController!
//                   .videoPlayerController.value.isInitialized
//           ? Chewie(
//               controller: _chewieController!,
//             )
//           : const Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircularProgressIndicator(),
//                 SizedBox(height: 20),
//                 Text('Loading'),
//               ],
//             ),
//     );
//   }
// }