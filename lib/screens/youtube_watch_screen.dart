import 'package:flutter/material.dart';
import 'package:project_v1/utils/app_routes.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeWatchScreen extends StatefulWidget {
  final String videoId;

  const YoutubeWatchScreen({Key? key, required this.videoId}) : super(key: key);

  @override
  State<YoutubeWatchScreen> createState() => _YoutubeWatchScreenState();
}

class _YoutubeWatchScreenState extends State<YoutubeWatchScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        disableDragSeek:
            true, // Disable user interaction with video controls // Start in fullscreen mode
        // Disable controls completely
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoute.videoMainScreen);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
    );
  }
}
