import 'dart:async';
import 'dart:io';

import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import '../../constant/theme/global_data.dart';
import '../../view_models/message/message_private_message_view_model.dart';

class RecorderView extends ConsumerStatefulWidget {
  const RecorderView({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _RecorderViewState();
}

class _RecorderViewState extends ConsumerState<RecorderView> {
  bool isRecording = false;
  String _recorderText = '00:00';
  String _playerText = '00:00';
  late FlutterSoundPlayer player;
  late FlutterSoundRecorder recorder;
  bool isPlayAudio = false;
  bool isPlayingSound = false;
  StreamSubscription? _recorderSubscription;
  StreamSubscription? _playerSubscription;
  Duration? recordDuration;
  late Directory tempDir;
  late String timeStamp;
  late MessagePrivateGroupMessageViewModel viewModel;
  String prefix = '';

  String audioFile = '';

  @override
  void initState() {
    viewModel = MessagePrivateGroupMessageViewModel(ref);
    // Future.delayed(Duration.zero, () async {
    //   prefix = await viewModel.getFilePrefix();
    //   print("prefix: ${prefix}");
    // });
    super.initState();
    // _initialize();
  }

  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    cancelPlayerSubscriptions();
    cancelRecorderSubscriptions();
    releaseFlauto();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UIDefine.getWidth(),
      height: UIDefine.getHeight(),
      color: AppColors.recordBackground.getColor(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (isRecording || isPlayAudio && isPlayingSound == false)
              ? Text(_recorderText,
                  style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500))
              : isPlayingSound
                  ? Text(_playerText,
                      style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500))
                  : Text(tr('clickToRecording'),
                      style: AppTextStyle.getBaseStyle(
                          fontSize: UIDefine.fontSize14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textWhiteOpacity5)),
          SizedBox(
            height: UIDefine.getPixelWidth(15),
          ),

          ///正在錄音
          isRecording
              ? GestureDetector(
                  onTap: () {
                    stopRecording();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: UIDefine.getPixelWidth(100),
                    height: UIDefine.getPixelWidth(100),
                    decoration: BoxDecoration(
                        color: AppColors.textWhiteOpacity5.getColor(),
                        borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(50)),
                        border: Border.all(color: AppColors.recorderRed.getColor(), width: UIDefine.getPixelWidth(4))),
                    child: Container(
                      width: UIDefine.getPixelWidth(18),
                      height: UIDefine.getPixelWidth(18),
                      decoration: BoxDecoration(
                          color: AppColors.recorderRed.getColor(), borderRadius: BorderRadius.circular(3)),
                    ),
                  ),
                )
              :
              ///預覽畫面
              isPlayAudio
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              _deleteRecording();
                            },
                            child: Image.asset(AppImagePath.delIcon)),
                        isPlayingSound
                            ? Container(
                                width: UIDefine.getPixelWidth(100),
                                height: UIDefine.getPixelWidth(100),
                                child: CircleProgressBar(
                                  animationDuration: recordDuration,
                                  foregroundColor: AppColors.mainThemeButton.getColor(),
                                  backgroundColor: AppColors.recordBackground.getColor(),
                                  strokeWidth: 3.0,
                                  value: 1.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPlayingSound = false;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: UIDefine.getPixelWidth(100),
                                      height: UIDefine.getPixelWidth(100),
                                      decoration: BoxDecoration(
                                        color: AppColors.buttonCommon.getColor().withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(50)),
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: UIDefine.getPixelWidth(18),
                                        height: UIDefine.getPixelWidth(18),
                                        decoration: BoxDecoration(
                                            color: AppColors.textWhite.getColor(),
                                            borderRadius: BorderRadius.circular(3)),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPlayingSound = true;
                                    playAudio();
                                  });
                                },
                                child: Container(
                                  width: UIDefine.getPixelWidth(100),
                                  height: UIDefine.getPixelWidth(100),
                                  decoration: BoxDecoration(
                                      color: AppColors.buttonCommon.getColor().withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(50)),
                                      border: Border.all(
                                          color: AppColors.mainThemeButton.getColor(),
                                          width: UIDefine.getPixelWidth(3))),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: UIDefine.getPixelWidth(50),
                                    height: UIDefine.getPixelWidth(50),
                                    child: Image.asset(
                                      AppImagePath.whitePlayIcon,
                                      fit: BoxFit.cover,
                                      width: UIDefine.getPixelWidth(32),
                                      height: UIDefine.getPixelWidth(32),
                                    ),
                                  ),
                                ),
                              ),
                        GestureDetector(
                            onTap: () {
                              // GlobalData.audioPath = '${tempDir.path}/$timeStamp.mp4';
                              _onSend();
                            },
                            child: Image.asset(
                              AppImagePath.sendIcon,
                            )),
                      ],
                    )
                  :

                  ///預設畫面
                  GestureDetector(
                      onTap: () {
                        _onTap();
                      },
                      child: Container(
                        width: UIDefine.getPixelWidth(100),
                        height: UIDefine.getPixelWidth(100),
                        decoration: BoxDecoration(
                            color: AppColors.textWhite.getColor().withOpacity(0.15),
                            borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(50)),
                            border: Border.all(
                                color: AppColors.buttonCommon.getColor().withOpacity(0.3),
                                width: UIDefine.getPixelWidth(2))),
                        child: Container(
                          alignment: Alignment.center,
                          width: UIDefine.getPixelWidth(32),
                          height: UIDefine.getPixelWidth(32),
                          child: Image.asset(
                            AppImagePath.goldenMicrophoneIcon,
                            fit: BoxFit.fill,
                            width: UIDefine.getPixelWidth(32),
                            height: UIDefine.getPixelWidth(32),
                          ),
                        ),
                      ),
                    ),
          SizedBox(
            height: UIDefine.getPixelWidth(15),
          ),

          Visibility(
              visible: isPlayAudio == true && recordDuration!.inSeconds >= 15,
              child: Text(
                tr('recordMaxTime'),
                style: AppTextStyle.getBaseStyle(
                    fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500, color: AppColors.textWhiteOpacity5),
              ))
        ],
      ),
    );
  }

  Future<void> _onTap() async {
    _initialize();
    final micRes = await getPermissionStatus(Permission.microphone);
    final stRes = await getPermissionStatus(Permission.storage);
    if (micRes == true && stRes == true) {
      setState(() {
        isRecording = true;
        _startRecording();
      });
    }
  }

  Future<void> _startRecording() async {
    recordDuration = Duration(seconds: 0);
    tempDir = await getApplicationDocumentsDirectory();
    timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    Directory directory = Directory(path.dirname('${tempDir.path}/$timeStamp.wav'));
    if (!directory.existsSync()) {
      directory.createSync();
    }
    await recorder.startRecorder(toFile: '${tempDir.path}/$timeStamp.wav', codec: Codec.pcm16WAV);
    _recorderSubscription = recorder.onProgress!.listen((e) {
      if (e.duration.inMilliseconds > 15010) {
        setState(() {
          _recorderText = '00:15';
          recordDuration = Duration(seconds: 17);
        });
        stopRecording();
      } else {
        var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds, isUtc: true);
        var timeText = DateFormat('mm:ss:SS', 'en_GB').format(date);
        setState(() {
          recordDuration = Duration(seconds: (e.duration.inSeconds + 1));
          _recorderText = timeText.substring(0, 5);
          // GlobalData.printLog('_recorderText${recordDuration}');
        });
      }
    });
  }

  Future<String?> stopRecording() async {
    setState(() {
      isRecording = false;
      isPlayAudio = true;
      cancelRecorderSubscriptions();
      recorder.closeRecorder();
    });
    return await recorder.stopRecorder();
  }

  Future<bool> getPermissionStatus(Permission category) async {
    Permission permission = category;
    //granted 通过，denied 被拒绝，permanentlyDenied 拒绝且不再提示
    PermissionStatus status = await permission.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      requestPermission(permission);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else if (status.isRestricted) {
      requestPermission(permission);
    } else {}
    return false;
  }

  ///申请權限
  void requestPermission(Permission permission) async {
    PermissionStatus status = await permission.request();
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _initialize() async {
    _recorderText = '00:00';
    player = FlutterSoundPlayer();
    recorder = FlutterSoundRecorder();
    await recorder.openRecorder();
    await recorder.setSubscriptionDuration(Duration(milliseconds: 10));
    await player.closePlayer();
    await player.openPlayer();
    // await player.setSpeed(1.0);
    await player.setSubscriptionDuration(Duration(milliseconds: 10));
    await initializeDateFormatting();
  }

  Future<void> playAudio() async {
    _playerText = '00:00';
    setState(() {
      isPlayingSound = true;
    });
    player.startPlayer(
        fromURI: '${tempDir.path}/$timeStamp.wav',
        codec: Codec.pcm16WAV, //_codec,
        whenFinished: () {
          setState(() {
            isPlayingSound = false;
          });
        });
    _addListeners();
  }

  void _addListeners() {
    _playerSubscription = player.onProgress!.listen((e) {
      GlobalData.printLog('e.position=${e.position}');
      var date = DateTime.fromMillisecondsSinceEpoch(e.position.inMilliseconds, isUtc: true);
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
      setState(() {
        _playerText = txt.substring(0, 5);
        // GlobalData.printLog('_playerText${_playerText}');
      });
    });
  }

  void cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription!.cancel();
      _recorderSubscription = null;
    }
  }

  void cancelPlayerSubscriptions() {
    if (_playerSubscription != null) {
      _playerSubscription!.cancel();
      _playerSubscription = null;
    }
  }

  Future<void> releaseFlauto() async {
    try {
      await player.closePlayer();
      await recorder.closeRecorder();
    } on Exception {
      player.logger.e('Released unsuccessful');
    }
  }

  Future<void> _deleteRecording() async {
    if (await File('${tempDir.path}/$timeStamp.wav').exists()) {
      await File('${tempDir.path}/$timeStamp.wav').delete();
    }
    if (isPlayingSound) {
      player.stopPlayer();
    }
    setState(() {
      isPlayAudio = false;
      isPlayingSound = false;
      _recorderText = '00:00';
      _playerText = '00:00';
    });
  }

  Future<void> _onSend() async {
    audioFile = await viewModel.uploadFile('audio', '${tempDir.path}/$timeStamp.wav');
    GlobalData.printLog("the audio: ${audioFile}");
    viewModel.onSendMessage(audioFile, false, "AUDIO");
    if (await File('${tempDir.path}/$timeStamp.wav').exists()) {
      await File('${tempDir.path}/$timeStamp.wav').delete();
    }
    setState(() {
      isPlayAudio = false;
      isPlayingSound = false;
      _recorderText = '00:00';
      _playerText = '00:00';
    });
  }
}
