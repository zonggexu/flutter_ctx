import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';

class TransparentVideoDemo extends StatefulWidget {
  const TransparentVideoDemo({super.key});
  @override
  State<TransparentVideoDemo> createState() => _TransparentVideoDemoState();
}

class _TransparentVideoDemoState extends State<TransparentVideoDemo> {
  late final VideoPlayerController _ctrl;
  late final Future<void> _init;

  @override
  void initState() {
    super.initState();
    // asset
    _ctrl = VideoPlayerController.asset(
      'assets/demo4.webm', // ← 透明素材
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..setLooping(true);

    // net
    // _ctrl = VideoPlayerController.networkUrl(
    //   Uri.parse(''),
    //   videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    // )..setLooping(true);
    _init = _ctrl.initialize();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // 方便观察透明效果
      body: Center(
        child: FutureBuilder(
          future: _init,
          builder: (_, snap) => snap.connectionState == ConnectionState.done
              ? AspectRatio(
                  aspectRatio: _ctrl.value.aspectRatio,
                  child: VideoPlayer(_ctrl),
                )
              : const CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_ctrl.value.isPlaying) {
            _ctrl.pause(); // 忽略返回的 Future
          } else {
            _ctrl.play(); // 同上
          }
          setState(() {}); // 仅触发重建，回调中不做任何异步事
        },
        child: Icon(
          _ctrl.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
