import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import '../constant/theme/app_colors.dart';
import '../constant/theme/app_gradient_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:just_audio/just_audio.dart';
import 'package:audioplayers/audioplayers.dart' as audio;

class PlayAudioBubble extends StatefulWidget {
  final String path;
  const PlayAudioBubble({
    required this.path,
    Key? key}) : super(key: key);

  @override
  State<PlayAudioBubble> createState() => _PlayAudioBubbleState();
}

class _PlayAudioBubbleState extends State<PlayAudioBubble> {
  bool isPlaying = false;
  bool isPaused = false;
  final player = AudioPlayer();
  late final Duration? duration;
  Duration? currentPosition;


  late Duration maxDuration;
  late Duration elapsedDuration;
  late List<String> audioData;
  late AudioCache audioPlayer;
  late int totalSamples;

  Future<void> parseData() async {
    final json = await rootBundle.loadString(audioData[0]);
    Map<String, dynamic> audioDataMap = {
      "json": json,
      "totalSamples": totalSamples,
    };
    await audioPlayer.load(audioData[1]);
    // maxDuration in milliseconds
    await Future.delayed(const Duration(milliseconds: 200));

    int maxDurationInmilliseconds =
    await audioPlayer.fixedPlayer!.getDuration();

    maxDuration = Duration(milliseconds: maxDurationInmilliseconds);
    setState(() {
      samples = samplesData["samples"];
    });
  }

  @override
  void initState() {
  Future.delayed(Duration.zero,()async{
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    await downloadFile(widget.path, '$appDocumentsDir/$timeStamp/msg.wav');


    duration = await player.setUrl(widget.path);
     player.positionStream.listen((position) {
       print('position=$position');
       setState(() {
         currentPosition = position;
       });
     });

    // await msgPlayer.closePlayer();
    // await msgPlayer.openPlayer();

    setState(() {

    });
  });
  // _init();
  super.initState();
  }

@override
  void didChangeDependencies() {
   setState(() {

   });
   super.didChangeDependencies();
  }

@override
void dispose() {
  // cancelPlayerSubscriptions();
  // releaseFlauto();
  player.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
  print('duration=${duration.toString().substring(2,7)}');
    return Container(
      width: UIDefine.getWidth()*0.5,
      height: UIDefine.getPixelWidth(50),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors:AppGradientColors.gradientBaseColorBg.getColors()),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(UIDefine.getPixelWidth(15)),topRight: Radius.circular(UIDefine.getPixelWidth(15)),bottomLeft: Radius.circular(UIDefine.getPixelWidth(15)),bottomRight: Radius.zero)
      ),
      child: Row(
        children: [
          SizedBox(width: UIDefine.getPixelWidth(5),),
          // StreamBuilder<PlayerState>(
          //   stream: player.playerStateStream,
          //   builder: (context, snapshot) {
          //     final playerState = snapshot.data;
          //     final processingState = playerState?.processingState;
          //     final playing = playerState?.playing;
          //     if (processingState == ProcessingState.loading ||
          //         processingState == ProcessingState.buffering) {
          //       return Container(
          //         width: UIDefine.getPixelWidth(30),
          //         height: UIDefine.getPixelWidth(30),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(15)),
          //           color: AppColors.buttonAudio.getColor().withOpacity(0.2)
          //         ),
          //         child:Image.asset(AppImagePath.blackPlayIcon),
          //       );
          //     } else if (playing != true) {
          //       return GestureDetector(
          //         onTap: (){
          //           setState(() {
          //             isPlaying = true;
          //             if(isPaused){
          //               isPaused = false;
          //             }
          //             player.play();
          //           });
          //         },
          //         child: Container(
          //           width: UIDefine.getPixelWidth(30),
          //           height: UIDefine.getPixelWidth(30),
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(15)),
          //               color: AppColors.buttonAudio.getColor().withOpacity(0.2)
          //           ),
          //           child:Image.asset(AppImagePath.blackPlayIcon),
          //         ),
          //       );
          //     } else if (processingState != ProcessingState.completed) {
          //       return GestureDetector(
          //         onTap: (){
          //           setState(() {
          //             isPlaying = false;
          //             isPaused = true;
          //             player.pause();
          //           });
          //
          //         },
          //         child: Container(
          //           width: UIDefine.getPixelWidth(30),
          //           height: UIDefine.getPixelWidth(30),
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(15)),
          //               color: AppColors.buttonAudio.getColor().withOpacity(0.2)
          //           ),
          //           child:Image.asset(AppImagePath.pauseBlackIcon),
          //         ),
          //       );
          //     } else {
          //       return
          //         GestureDetector(
          //           onTap: (){
          //             setState(() {
          //               isPlaying = true;
          //               player.seek(Duration.zero);
          //             });
          //           },
          //           child: Container(
          //             width: UIDefine.getPixelWidth(30),
          //             height: UIDefine.getPixelWidth(30),
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(15)),
          //                 color: AppColors.buttonAudio.getColor().withOpacity(0.2)
          //             ),
          //             child:Image.asset(AppImagePath.blackPlayIcon),
          //           ),
          //         );
          //     }
          //   },
          // ),
          SizedBox(width: UIDefine.getPixelWidth(10),),
          isPlaying == true || isPaused == true?
          Text(currentPosition.toString().substring(2,7),style: AppTextStyle.getBaseStyle(color: AppColors.textBlack,fontSize: UIDefine.fontSize14,fontWeight: FontWeight.w400),):
          Text(duration.toString().substring(2,7),style: AppTextStyle.getBaseStyle(color: AppColors.textBlack,fontSize: UIDefine.fontSize14,fontWeight: FontWeight.w400),),
          SizedBox(width: UIDefine.getPixelWidth(10),),
          // _buildWaveform()
        ],
      ),
    );
  }



Future<void> downloadFile(String url, String savePath) async {
    Dio dio = Dio();
    File file = File(savePath);

    try {
      if (file.existsSync()) {
        await file.delete();
      }
      await dio.download(url, savePath);
    } catch (e) {
      print('下载文件出错：$e');
    }
  }



}
