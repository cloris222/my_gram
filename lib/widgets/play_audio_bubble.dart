import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:flutter/cupertino.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

import '../constant/theme/app_colors.dart';
import '../constant/theme/app_gradient_colors.dart';

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
String playText = '00:00';
late PlayerController controller;
late final waveformData;

  @override
  void initState() {
    PlayerController controller = PlayerController();
   Future.delayed(Duration.zero,()async{
     waveformData = await controller.extractWaveformData(
       path: widget.path,
       noOfSamples: 100,
     );
   });
    super.initState();
  }

  @override
  void dispose() {
    controller.stopPlayer();                                         // Stop all registered audio players
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UIDefine.getWidth()*0.3,
      height: UIDefine.getPixelWidth(60),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors:AppGradientColors.gradientBaseColorBg.getColors()),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(UIDefine.getPixelWidth(15)),topRight: Radius.circular(UIDefine.getPixelWidth(15)),bottomLeft: Radius.circular(UIDefine.getPixelWidth(15)),bottomRight: Radius.zero)
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              _onTap();
            },
            child: Container(
              width: UIDefine.getPixelWidth(10),
              height: UIDefine.getPixelWidth(10),
              decoration: BoxDecoration(
                color: AppColors.buttonCommon.getColor().withOpacity(0.4),
                borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(5))
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
          _buildAudioWave()
        ],
      ),
    );
  }

  Future<void>_onTap()async{
    if(isPlaying == false){
      setState(() {
        isPlaying = true;
      });
      await controller.startPlayer(finishMode: FinishMode.stop);
    }else{
      setState(() {
        isPlaying = false;
      });
      await controller.pausePlayer();
    }
  }

  Widget _buildAudioWave(){
    return AudioFileWaveforms(
        size: Size(UIDefine.getWidth()*0.1, UIDefine.getPixelWidth(50),),
        playerController: controller,
        enableSeekGesture: true,
        waveformType: WaveformType.long,
        waveformData: waveformData,
        playerWaveStyle: PlayerWaveStyle(
            fixedWaveColor:AppColors.bolderGrey.getColor(),
            liveWaveColor: AppColors.textBlack.getColor(),
            spacing: 6,
        ),
    );
  }
}
