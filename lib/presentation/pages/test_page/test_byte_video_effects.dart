import 'dart:io';
import 'package:flutter_ctx/core/utils/log_util.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alpha_player_plugin/alpha_player_controller.dart';
import 'package:flutter_alpha_player_plugin/alpha_player_view.dart';
import 'package:path_provider/path_provider.dart';

class TestByteVideoEffects extends StatefulWidget {
  const TestByteVideoEffects({super.key});

  @override
  State<TestByteVideoEffects> createState() => TestByteVideoEffectsState();
}

class TestByteVideoEffectsState extends State<TestByteVideoEffects> {
  @override
  void initState() {
    super.initState();
    AlphaPlayerController.setAlphaPlayerCallBack(
      endAction: () {},
      startAction: () {},
      monitorCallbacks: (expand) {},
      onVideoSizeChanged: (expand) {},
      platformCallback: (ex) {
        Slog("message $ex");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("神秘空间"),
      ),
      body: Builder(builder: (context) {
        return Center(
            child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                CupertinoButton(
                  color: Colors.purple,
                  child: Text("播放assets demo1.mp4"),
                  onPressed: () async {
                    if (Platform.isAndroid) {
                      /// 安卓路径读取方式 需要绝对路径  后期追加 预加载逻辑 以便直接使用
                      File viedeoFile = await androidcopyAssetToTemp("assets/demo5.mp4");
                      Slog("-------------${viedeoFile.path}->");

                      AlphaPlayerController.playVideo(p.dirname(viedeoFile.path), "demo5.mp4",
                          portraitPath: 7, landscapePath: 1);
                    } else if (Platform.isIOS) {
                      /// iOS 路径读取方式
                      /// iOS 由于基于字节播放器的二次封装，内部需要解析config.json 文件来读取资源，所以，视频同级目录内都要有一个对应的config.json文件
                      /// assets 文件夹，也可替换为自定义的文件夹
                      AlphaPlayerController.playAssetVideo("assets", "demo1.mp4");
                    }
                  },
                ),
                SizedBox(height: 10),
                CupertinoButton(
                  color: Colors.purple,
                  child: Text("attachView"),
                  onPressed: () {
                    AlphaPlayerController.attachView();
                  },
                ),
                SizedBox(height: 10),
                CupertinoButton(
                  color: Colors.purple,
                  child: Text("detachView"),
                  onPressed: () {
                    AlphaPlayerController.detachView();
                  },
                ),
                SizedBox(height: 10),
                CupertinoButton(
                  color: Colors.purple,
                  child: Text("releasePlayer"),
                  onPressed: () {
                    AlphaPlayerController.releasePlayer();
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
            IgnorePointer(
              child: SizedBox(width: 375, height: 812, child: const AlphaPlayerView()),
            ),
          ],
        ));
      }),
    );
  }

  Future<File> androidcopyAssetToTemp(String assetPath) async {
    final data = await rootBundle.load(assetPath); // 1
    final bytes = data.buffer.asUint8List();
    final cache = await getTemporaryDirectory();
    final file = File(p.join(cache.path, p.basename(assetPath)));
    await file.writeAsBytes(bytes, flush: true);
    final exists = await file.exists();
    Slog("文件拷贝情况: ${exists} ");
    return file;
  }
}
