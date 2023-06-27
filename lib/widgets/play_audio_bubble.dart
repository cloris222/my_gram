import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'dart:io';
import '../constant/theme/app_colors.dart';
import '../constant/theme/app_gradient_colors.dart';
import 'package:audioplayers/audioplayers.dart' as audio;
import 'dart:math' as math;
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart'
    as flutterAudio;

import '../constant/theme/app_image_path.dart';

class PlayAudioBubble extends StatefulWidget {
  final String path;

  const PlayAudioBubble({required this.path, Key? key}) : super(key: key);

  @override
  State<PlayAudioBubble> createState() => _PlayAudioBubbleState();
}

class _PlayAudioBubbleState extends State<PlayAudioBubble> {
  Duration? currentPosition;
  late Duration maxDuration;
  late Duration elapsedDuration;
  final audio.AudioPlayer player = audio.AudioPlayer();

  late List<String> audioData;

  Duration? duration;
  var playerState;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await player.setSourceUrl(widget.path);
      duration = await player.getDuration();
      playerState = player.state;
      player.onPlayerStateChanged.listen((audio.PlayerState s) {
        print('Current player state: $s');
        setState(() => playerState = s);
      });
      player.onPositionChanged.listen((position) {
        print('position=$position');
        setState(() {
          currentPosition = position;
        });
      });
      // final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      // final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      // await downloadFile(widget.path, '$appDocumentsDir/$timeStamp/msg.wav');
      //
      //
      // duration = await player.setUrl(widget.path);

      // await msgPlayer.closePlayer();
      // await msgPlayer.openPlayer();

      setState(() {});
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('duration222=$duration');
    // print('duration=${duration.toString().substring(2,7)}');
    return Container(
      width: UIDefine.getWidth() * 0.5,
      height: UIDefine.getPixelWidth(50),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: AppGradientColors.gradientBaseColorBg.getColors()),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(UIDefine.getPixelWidth(15)),
              topRight: Radius.circular(UIDefine.getPixelWidth(15)),
              bottomLeft: Radius.circular(UIDefine.getPixelWidth(15)),
              bottomRight: Radius.zero)),
      child: Row(
        children: [
          SizedBox(
            width: UIDefine.getPixelWidth(5),
          ),
          _buildActionButton(),
          SizedBox(
            width: UIDefine.getPixelWidth(10),
          ),
          playerState == audio.PlayerState.playing ||
                  playerState == audio.PlayerState.paused
              ? Text(
                  currentPosition.toString().substring(2, 7),
                  style: AppTextStyle.getBaseStyle(
                      color: AppColors.textBlack,
                      fontSize: UIDefine.fontSize14,
                      fontWeight: FontWeight.w400),
                )
              : Text(
                  duration.toString().substring(2, 7),
                  style: AppTextStyle.getBaseStyle(
                      color: AppColors.textBlack,
                      fontSize: UIDefine.fontSize14,
                      fontWeight: FontWeight.w400),
                ),
          SizedBox(width: UIDefine.getPixelWidth(15),),
          RectangleWaveform(
            maxDuration: duration ?? Duration.zero,
            elapsedDuration: currentPosition ?? Duration.zero,
            samples: [0, -2, 3, 10, 4, 10, 6, 3, 10, 0, 4, 14, 4, 10, 6, 3, 10, 0, 4, 6, 4, 10, 6, 3, 10,8, 5, 3],
            height: UIDefine.getPixelWidth(30),
            width: UIDefine.getPixelWidth(70),
            inactiveColor: AppColors.buttonAudio.getColor().withOpacity(0.3),
            activeColor: Colors.black87,
            activeBorderColor: Colors.transparent,
            inactiveBorderColor: Colors.transparent,
            showActiveWaveform: true,
            isRoundedRectangle: true,
            isCentered: true,
            borderWidth: 0,
          ),
          SizedBox(
            width: UIDefine.getPixelWidth(10),
          ),
          // _buildWaveform()
        ],
      ),
    );
  }

  // Future<void> downloadFile(String url, String savePath) async {
  //   Dio dio = Dio();
  //   File file = File(savePath);
  //
  //   try {
  //     if (file.existsSync()) {
  //       await file.delete();
  //     }
  //     await dio.download(url, savePath);
  //   } catch (e) {
  //     print('下载文件出错：$e');
  //   }
  // }

  Widget _buildActionButton() {
    if (playerState == audio.PlayerState.stopped) {
      return GestureDetector(
        onTap: () {
          setState(() {
            player.play(UrlSource(widget.path));
          });
        },
        child: Container(
          width: UIDefine.getPixelWidth(30),
          height: UIDefine.getPixelWidth(30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(15)),
              color: AppColors.buttonAudio.getColor().withOpacity(0.2)),
          child: Image.asset(AppImagePath.blackPlayIcon),
        ),
      );
    } else if (playerState == audio.PlayerState.playing) {
      return GestureDetector(
        onTap: () {
          setState(() {
            player.pause();
          });
        },
        child: Container(
          width: UIDefine.getPixelWidth(30),
          height: UIDefine.getPixelWidth(30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(15)),
              color: AppColors.buttonAudio.getColor().withOpacity(0.2)),
          child: Image.asset(AppImagePath.pauseBlackIcon),
        ),
      );
    } else if (playerState == audio.PlayerState.paused) {
      return GestureDetector(
        onTap: () {
          player.resume();
        },
        child: Container(
          width: UIDefine.getPixelWidth(30),
          height: UIDefine.getPixelWidth(30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(15)),
              color: AppColors.buttonAudio.getColor().withOpacity(0.2)),
          child: Image.asset(AppImagePath.blackPlayIcon),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            player.play(UrlSource(widget.path));
          });
        },
        child: Container(
          width: UIDefine.getPixelWidth(30),
          height: UIDefine.getPixelWidth(30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(15)),
              color: AppColors.buttonAudio.getColor().withOpacity(0.2)),
          child: Image.asset(AppImagePath.blackPlayIcon),
        ),
      );
    }
  }

  Map<String, dynamic> loadparseJson(Map<String, dynamic> audioDataMap) {
    final data = jsonDecode(audioDataMap["json"]);

    final List<int> rawSamples = List<int>.from(data['data']);
    List<int> filteredData = [];
    // Change this value to number of audio samples you want.
    // Values between 256 and 1024 are good for showing [RectangleWaveform] and [SquigglyWaveform]
    // While the values above them are good for showing [PolygonWaveform]
    final int totalSamples = audioDataMap["totalSamples"];
    final double blockSize = rawSamples.length / totalSamples;

    for (int i = 0; i < totalSamples; i++) {
      final double blockStart =
          blockSize * i; // the location of the first sample in the block
      int sum = 0;
      for (int j = 0; j < blockSize; j++) {
        sum = sum +
            rawSamples[(blockStart + j).toInt()]
                .toInt(); // find the sum of all the samples in the block
      }
      filteredData.add((sum / blockSize)
          .round() // take the average of the block and add it to the filtered data
          .toInt()); // divide the sum by the block size to get the average
    }
    final maxNum = filteredData.reduce((a, b) => math.max(a.abs(), b.abs()));

    final double multiplier = math.pow(maxNum, -1).toDouble();

    final samples = filteredData.map<double>((e) => (e * multiplier)).toList();

    return {
      "samples": samples,
    };
  }
}
