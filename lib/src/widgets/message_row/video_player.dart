part of dash_chat_2;

/// @nodoc
class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    required this.url,
    this.aspectRatio = 1,
    this.canPlay = true,
    this.onPlay,
  });

  /// On press play
  final VoidCallback? onPlay;

  /// Link of the video
  final String url;

  /// The Aspect Ratio of the Video. Important to get the correct size of the video
  final double aspectRatio;

  /// If the video can be played
  final bool canPlay;

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  vp.VideoPlayerController? _controller;
  ChewieController? _chewieController;
  Widget? _cheWiewWidget;
  @override
  void initState() {
    _controller = vp.VideoPlayerController.network(widget.url);

    _controller!.addListener(() {
      setState(() {
        _chewieController =
            ChewieController(videoPlayerController: _controller!);
        _cheWiewWidget = Chewie(
          controller: _chewieController!,
        );
      });
    });
    _controller!.initialize();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
    _chewieController?.dispose();
    _chewieController = null;
    _controller = null;
  }

  Future<void> _initializeVideoPlayerFuture() async {
    // if (_controller == null) {
    //   _controller = vp.VideoPlayerController.network(widget.url);
    //   await _controller!.initialize();
    // }
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<void>(
    //   future: _initializeVideoPlayerFuture(),
    //   builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    return _controller!.value.isInitialized
        ? _cheWiewWidget!
        // ? Stack(
        //     alignment: _controller!.value.isPlaying
        //         ? AlignmentDirectional.bottomStart
        //         : AlignmentDirectional.center,
        //     children: <Widget>[
        //       AspectRatio(
        //         aspectRatio: _controller!.value.aspectRatio,
        //         child: vp.VideoPlayer(_controller!),
        //       ),
        //       IconButton(
        //         iconSize: _controller!.value.isPlaying ? 24 : 60,
        //         onPressed: widget.canPlay
        //             ? () {
        //                 if (widget.onPlay != null) {
        //                   widget.onPlay!();
        //                   return;
        //                 }
        //                 setState(() {
        //                   _controller!.value.isPlaying
        //                       ? _controller!.pause()
        //                       : _controller!.play();
        //                 });
        //               }
        //             : null,
        //         icon: Icon(
        //           _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
        //           color: Colors.white,
        //           // size: 60,
        //         ),
        //       ),
        //     ],
        //   )
        : Container();
    //   }
    //   return Container();
    // },
    // );
  }
}
