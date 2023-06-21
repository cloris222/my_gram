import 'dart:async';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:io';
import '../constant/theme/app_colors.dart';
import '../constant/theme/app_gradient_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:just_waveform/just_waveform.dart';

import 'audio_wave_form_widget.dart';

class PlayAudioBubble extends StatefulWidget {
  final String path;
  const PlayAudioBubble({
    required this.path,
    Key? key}) : super(key: key);

  @override
  State<PlayAudioBubble> createState() => _PlayAudioBubbleState();
}

class _PlayAudioBubbleState extends State<PlayAudioBubble> {
  // final progressStream = BehaviorSubject<WaveformProgress>();
  bool isPlaying = false;
String playText = '00:00';
 FlutterSoundPlayer msgPlayer = FlutterSoundPlayer();
StreamSubscription? _playerSubscription;
// late File audioFile;
// late File? waveFile;

@override
  void initState() {
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
  cancelPlayerSubscriptions();
  releaseFlauto();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
  GlobalData.printLog('path=${widget.path}');
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
          GestureDetector(
            onTap: (){
              _onTap();
            },
            child: Container(
              width: UIDefine.getPixelWidth(30),
              height: UIDefine.getPixelWidth(30),
              decoration: BoxDecoration(
                color: AppColors.buttonCommon.getColor().withOpacity(0.8),
                borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(15))
              ),
              child:
              isPlaying?
              Image.asset(AppImagePath.pauseBlackIcon):
              Image.asset(AppImagePath.blackPlayIcon),
            ),
          ),
          SizedBox(width: UIDefine.getPixelWidth(10),),
          Text(playText,style: AppTextStyle.getBaseStyle(color: AppColors.textBlack,fontSize: UIDefine.fontSize14,fontWeight: FontWeight.w400),),
          SizedBox(width: UIDefine.getPixelWidth(10),),
          // _buildWaveform()
        ],
      ),
    );
  }

  Future<void>_onTap()async{
  ///一開始播放
  if(!isPlaying && !msgPlayer.isPaused){
    //   final tempDir = await getApplicationDocumentsDirectory();
    // String url = widget.path;
    // String savePath = '${tempDir.path}/waveform/${widget.path}.wav';
    // await downloadFile(url, savePath);
    msgPlayer.openPlayer();
    setState(() {
      isPlaying = true;
    });
    playText = '00:00';
    setState(() {
      isPlaying = true;
    });
    msgPlayer.startPlayer(
        fromURI: widget.path,
        codec: Codec.pcm16WAV, //_codec,
        whenFinished: (){
          setState(() {
            isPlaying = false;
          });
        }
    );

    // _addListeners();
  }else if(!isPlaying && msgPlayer.isPaused){
    ///暫停後恢復播放
    setState(() {
      isPlaying = true;
    });
    msgPlayer.resumePlayer();
  }else{
    ///暫停
    setState(() {
      isPlaying = false;
    });
    msgPlayer.pausePlayer();
  }
}

void _addListeners() {
  _playerSubscription = msgPlayer.onProgress!.listen((e) {
    var date = DateTime.fromMillisecondsSinceEpoch(e.position.inMilliseconds,
        isUtc: true);
    var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
    setState(() {
      GlobalData.printLog('_playerText${playText}');
      playText = txt.substring(0, 5);
    });
  });
}

void cancelPlayerSubscriptions() {
  if (_playerSubscription != null) {
    _playerSubscription!.cancel();
    _playerSubscription = null;
  }
}

Future<void> releaseFlauto() async {
  try {
    await msgPlayer.closePlayer();
  } on Exception {
    msgPlayer.logger.e('Released unsuccessful');
  }
}

// Future<void> _init() async {
//   final tempDir = await getApplicationDocumentsDirectory();
//   String url = widget.path;
//   String savePath = '${tempDir.path}/waveform.wav';
//   await downloadFile(url, savePath);
//   audioFile = File('waveform.wav');
//   await audioFile.writeAsBytes(
//       (await rootBundle.load('${tempDir.path}/waveform.wav')).buffer.asUint8List());
//   waveFile =
//       File('${tempDir.path}/waveform.wave');
//   final progressStream = JustWaveform.extract(
//     audioInFile: audioFile,
//     waveOutFile: waveFile!,
//     zoom: const WaveformZoom.pixelsPerSecond(100),
//   );
//   progressStream.listen((waveformProgress) {
//     print('Progress: %${(100 * waveformProgress.progress).toInt()}');
//     if (waveformProgress.waveform != null) {
//       // Use the waveform.
//     }
//   });
//
// }
//
// Widget _buildWaveform(){
//   return StreamBuilder<WaveformProgress>(
//     stream: progressStream,
//     builder: (context,snapshot){
//       if (snapshot.hasError) {
//         return Center(
//           child: Text(
//             'Error: ${snapshot.error}',
//             style: Theme.of(context).textTheme.titleLarge,
//             textAlign: TextAlign.center,
//           ),
//         );
//       }
//       final progress = snapshot.data?.progress ?? 0.0;
//       final waveform = snapshot.data?.waveform;
//       if (waveform == null) {
//         return Center(
//           child: Text(
//             '${(100 * progress).toInt()}%',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//         );
//       }
//       return AudioWaveformWidget(
//         waveform: waveform,
//         start: Duration.zero,
//         duration: waveform.duration,
//       );
//     },
//   );
// }
//
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
