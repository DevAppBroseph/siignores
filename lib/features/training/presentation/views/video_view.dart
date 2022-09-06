import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String url;
  final Duration? duration;
  const VideoView({Key? key, required this.url, required this.duration})
      : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late FlickManager flickManager;
  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    print('VIDEO: ${widget.url}');
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(widget.url));

    seekTo(widget.duration);
  }

  seekTo(Duration? duration) async {
    await Future.delayed(const Duration(seconds: 1));
    if (widget.duration != null) {
      setState(() {
        flickManager.flickVideoManager!.videoPlayerController!
            .seekTo(const Duration(seconds: 5));
      });
    }
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              SizedBox(
                width: 20.w,
              ),
              Icon(
                Icons.close,
                color: Colors.white,
                size: 30.w,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: FlickVideoPlayer(
                flickManager: flickManager,
                flickVideoWithControls: const FlickVideoWithControls(
                  closedCaptionTextStyle: TextStyle(fontSize: 8),
                  controls: FlickPortraitControls(),
                ),
                flickVideoWithControlsFullscreen: const FlickVideoWithControls(
                  controls: FlickLandscapeControls(),
                ),
              ),
            ),
            SizedBox(
              height: 70.h,
            )
          ],
        ),
      ),
    );
  }
}
