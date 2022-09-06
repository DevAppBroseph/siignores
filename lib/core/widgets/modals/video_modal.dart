import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoModal {
  BuildContext context;
  FlickManager flickManager;
  VideoModal({required this.context, required this.flickManager});

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.h),
              ),
            ),
            insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              width: 300.w,
              height: 200.w,
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
            ));
      },
    );
  }
}
