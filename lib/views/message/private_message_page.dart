import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_gradient_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/views/message/recorder_view.dart';
import 'package:base_project/views/sqlite/data/chat_history_sqlite.dart';
import 'package:base_project/widgets/appbar/custom_app_bar.dart';
import 'package:base_project/widgets/label/common_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../constant/theme/ui_define.dart';
import '../../models/http/data/chat_room_data.dart';
import '../../view_models/message/chat_room_provider.dart';
import '../../widgets/play_audio_bubble.dart';
import '../common_scaffold.dart';
import 'data/message_chatroom_detail_response_data.dart';
import '../../view_models/message/message_private_message_view_model.dart';
import 'gallery_view.dart';

class PrivateMessagePage extends ConsumerStatefulWidget {
  // final ChatRoomData data;

  const PrivateMessagePage({
    Key? key,
    //  required this.data
  }) : super(key: key);

  @override
  ConsumerState createState() => _PrivateMessagePageState();
}

class _PrivateMessagePageState extends ConsumerState<PrivateMessagePage> {
  MessagePrivateGroupMessageViewModel viewModel =
      MessagePrivateGroupMessageViewModel();

  bool showGallery = false;
  bool sendImage = false;
  String friendName = "Rebecca";
  String friendAvatar = "3";
  String roomId = "1";

  // var listViewKey = RectGet
  // bool bShowReply = false;
  // bool bImage = false;
  // bool bGroup = false;
  ChatHistorySQLite replyByMessageData = ChatHistorySQLite();
  MessageChatroomDetailResponseData _chatroomDetailData =
      MessageChatroomDetailResponseData();

  late PermissionState ps = PermissionState.notDetermined;

  // final TextEditingController _textController = TextEditingController();

  List<AssetEntity> get imageList => ref.read(chatRoomProvider);
  List<AssetEntity> showImageList = [];
  bool showRecorder = false;

  String get filePrefix =>ref.read(filePrefixProvider);
  String get filePath =>ref.read(msgFilePathProvider);

  @override
  initState() {
    Future.delayed(Duration.zero,()async{
      final prefix = await viewModel.getFilePrefix();
    });
    super.initState();
    // Future<MessageChatroomDetailResponseData> userData = viewModel.getChatroomDetail(roomId);
    // userData.then((value) => {
    //   _chatroomDetailData = value,
    // bNormal = _chatroomDetailData.blockStatus != 'blocked',
    // _updateUnreadCount(),
    // _setUserData(),
    // _onReadMessageForInit()
    // });
    // initWebSocket();
  }

  @override
  void didUpdateWidget(covariant PrivateMessagePage oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: CustomAppBar.chatRoomAppBar(context,
          nickName: friendName, avatar: friendAvatar),
      body: (isDark) => Container(
        width: UIDefine.getWidth(),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: AppGradientColors.gradientBlackGoldColors.getColors())),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              color: Colors.transparent,
            ),
            Column(
              children: [
                SizedBox(height: UIDefine.getPixelWidth(10),),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     PlayAudioBubble(path:GlobalData.audioPath,),
                //     SizedBox(width: UIDefine.getPixelWidth(10),)
                //   ],
                // ),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(chatRoomProvider);
                    return Expanded(
                      child: Container(
                          // child: NotificationListener<ScrollNotification>(
                          //   onNotification: (notification) {

                          //   },
                          // ),
                          ),
                      // child: showImageList.isNotEmpty
                      // ? ListView.builder(
                      //   shrinkWrap: true,
                      //   itemCount: showImageList.length,
                      //   itemBuilder: (context, index) {
                      //     return AssetEntityImage(
                      //       showImageList[index],
                      //       width: UIDefine.getPixelWidth(200),
                      //       height: UIDefine.getPixelWidth(200),
                      //     );
                      //   })
                      // : Container(),
                    );
                  },
                ),
                _getBottomNavigationBar()
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _getBottomNavigationBar()
    );
  }

  _getBottomNavigationBar() {
    return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
            height: showGallery || showRecorder
                ? UIDefine.getHeight() * 0.4
                : UIDefine.getPixelWidth(40),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      right: UIDefine.getPixelWidth(8),
                      bottom: UIDefine.getPixelWidth(5)),
                  width: UIDefine.getWidth(),
                  height: UIDefine.getPixelWidth(40),
                  decoration: BoxDecoration(
                      color: AppColors.dialogBackground.getColor(),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 1,
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(top: UIDefine.getPixelWidth(7)),
                        width: UIDefine.getWidth() * 0.85,
                        height: UIDefine.getPixelWidth(40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: AppColors.dialogBackground.getColor(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ///工具列
                            SizedBox(width: UIDefine.getPixelWidth(10)),
                            InkWell(onTap: () {}, child: Icon(Icons.add)),

                            ///拍照
                            SizedBox(width: UIDefine.getPixelWidth(10)),
                            InkWell(
                                onTap: () {}, child: Icon(Icons.photo_camera)),

                            ///相簿
                            SizedBox(width: UIDefine.getPixelWidth(10)),
                            InkWell(
                                onTap: () {
                                  _openGallery();
                                },
                                child: Icon(Icons.photo)),
                            SizedBox(width: UIDefine.getPixelWidth(10)),

                            Stack(
                              children: [
                                ///輸入框
                                Container(
                                  width: UIDefine.getPixelWidth(180),
                                  height: UIDefine.getPixelWidth(40),
                                  padding: EdgeInsets.only(
                                      bottom: UIDefine.getPixelWidth(2)),
                                  child: TextField(
                                    // focusNode: _focusNode,
                                    controller: viewModel.textController,
                                    style: AppTextStyle.getBaseStyle(
                                        color: AppColors.buttonPrimaryText,
                                        fontSize: UIDefine.fontSize12),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: tr('writeAMessage'),
                                      hintStyle: AppTextStyle.getBaseStyle(
                                          fontSize: UIDefine.fontSize12,
                                          color: AppColors.textPrimary),
                                      fillColor:
                                          AppColors.bolderGrey.getColor(),
                                      filled: true,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: UIDefine.getPixelWidth(5),
                                    right: 0,
                                    child:
                                    viewModel.textController.text == ''?
                                    GestureDetector(
                                      onTap: () {
                                        _onTapMicrophone();
                                      },
                                      child: Image.asset(
                                          AppImagePath.microphoneIcon,
                                        color: showRecorder?Colors.blue:AppColors.textWhite.getColor(),
                                      ),
                                    ):
                                    GestureDetector(
                                      onTap: () {
                                        viewModel.onSendMessage(
                                            viewModel.textController.text, false);
                                      },
                                      child: Icon(Icons.send)
                                    )
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                showGallery
                    ? Flexible(
                        child: Visibility(
                            visible: showGallery,
                            child: Column(
                              children: [
                                Divider(
                                  height: 1.0,
                                ),
                                Expanded(
                                  child: Container(
                                      width: UIDefine.getWidth(),
                                      child: GalleryView(
                                        ps: ps,
                                      )),
                                )
                              ],
                            )),
                      )
                    : showRecorder
                        ? Flexible(
                  child: Visibility(
                      visible: showRecorder,
                      child: Column(
                        children: [
                          Divider(
                            height: 1.0,
                          ),
                          Expanded(
                            child: Container(
                                width: UIDefine.getWidth(),
                                child: RecorderView()),
                          )
                        ],
                      )),
                )
                        : SizedBox()
              ],
            )));
  }

  Future<void> _openGallery() async {
    await _getPermission();
    setState(() {
      showGallery = !showGallery;
    });
  }

  Future<PermissionState> _getPermission() async {
    ps = await PhotoManager.requestPermissionExtend();
    return ps;
  }

  // _sendMessage() {
  //   if (imageList == []) return;
  //   setState(() {
  //     _sendImage().then((value) => ref.read(chatRoomProvider.notifier).clearImageList());
  //     sendImage = false;
  //     showGallery = false;
  //   });
  // }

  void _onTapMicrophone() {
    setState(() {
      print('showRecorder');
      showRecorder = !showRecorder;
    });
  }

  Future<void> _sendImage() async {
    setState(() {
      showImageList.addAll(imageList);
    });
  }
}
