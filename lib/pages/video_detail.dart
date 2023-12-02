import 'package:flutter/material.dart';
import 'package:p2p_client/widgets/base_state.dart';
import 'package:video_player/video_player.dart';

import '../widgets/base_stateful_widget.dart';


class VideoDetail extends BaseStatefulWidget {
  final Object? arguments;

  VideoDetail({Key? key, this.arguments}) : super(key: key);

  @override
  State createState() => _VideoDetailState();
}

class _VideoDetailState extends BaseState<VideoDetail> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}