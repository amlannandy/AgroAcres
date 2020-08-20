import 'package:AgroAcres/widgets/LoadingSpinner.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import './SettingsScreen/local_widgets/WhiteAppBar.dart';

class VideoScreen extends StatefulWidget {
  final String title;
  final String url;

  VideoScreen(this.title, this.url);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void togglePlayback() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, widget.title),
      backgroundColor: Colors.white,
      body: Center(
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: 9 / 16,
                child: VideoPlayer(_controller),
              )
            : loadingSpinner(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: togglePlayback,
        backgroundColor: Colors.black.withOpacity(0.8),
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white.withOpacity(0.8),
        ),
      ),
    );
  }
}
