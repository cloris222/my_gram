import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_gradient_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_gradient_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/models/http/data/dynamic_info_data.dart';
import 'package:base_project/utils/pitch_data_util.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/views/message/recorder_view.dart';
import 'package:base_project/view_models/message/websocketdata/ws_send_message_data.dart';
import 'package:base_project/views/message/sqlite/chat_history_db.dart';
import 'package:base_project/views/message/widget/message_view_for_other.dart';
import 'package:base_project/widgets/label/avatar_icon_widget.dart';
import '../../constant/theme/app_style.dart';
import '../../views/message/sqlite/data/chat_history_sqlite.dart';
import 'package:base_project/widgets/appbar/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:rect_getter/rect_getter.dart';
import '../../constant/theme/ui_define.dart';
import '../../view_models/message/chat_room_provider.dart';
import '../../widgets/play_audio_bubble.dart';
import '../common_scaffold.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'data/message_chatroom_detail_response_data.dart';
import '../../view_models/message/message_private_message_view_model.dart';
import 'gallery_view.dart';
import '../../utils/date_format_util.dart';
import '../../views/message/data/message_view_for_updating.dart';
import '../../views/message/widget/message_view_for_self.dart';
import 'notifier/chat_msg_notifier.dart';

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
  MessagePrivateGroupMessageViewModel viewModel = MessagePrivateGroupMessageViewModel();

  bool showGallery = false;
  bool sendImage = false;
  String friendName = "Rebecca";
  // String friendAvatar = "1";
  // String roomId = "3";
  String sMyID = GlobalData.userMemberId;
  // var listViewKey = RectGet
  // bool bShowReply = false;
  // bool bImage = false;
  // bool bGroup = false;
  ChatHistorySQLite replyByMessageData = ChatHistorySQLite();
  MessageChatroomDetailResponseData _chatroomDetailData = MessageChatroomDetailResponseData();

  var listViewKey = RectGetter.createGlobalKey(); // 聊天訊息的ListView Key
  List<ChatHistorySQLite> showingList = []; // 顯示雙方訊息用的DataList
  var _keys = {}; // ListItem的key集合
  late PermissionState ps = PermissionState.notDetermined;
  late ChatMsgNotifier _chatMsgNotifier; // 訊息之Notifier
  List<AssetEntity> get imageList => ref.read(chatRoomProvider);
  List<AssetEntity> showImageList = [];
  bool showRecorder = false;

  // String get filePrefix =>ref.read(filePrefixProvider);
  // String get filePath =>ref.read(msgFilePathProvider);

  @override
  initState() {
    Future.delayed(Duration.zero,()async{
      final prefix = await viewModel.getFilePrefix();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final updateList = ref.read(listImgNotiferProvider.notifier);
      updateList.addData();
      print("im List: ${imageList.length}");
    });
    viewModel.textFocusNode.addListener(() {
      Future.delayed(Duration(milliseconds: 300)).then((value) {
        setState(() {
          viewModel.isFocus = viewModel.textFocusNode.hasFocus;
        });
      });
    });
    _getDbDataToShow();
    _onNotifierListener();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.textFocusNode.dispose();
    super.dispose();
  }

  _onNotifierListener() {
    _chatMsgNotifier = GlobalData.chatMsgNotifier;
    _chatMsgNotifier.addListener(() {
      if (mounted) {
        GlobalData.printLog('有收到訊息回傳: 單聊聊天室');
        if (viewModel.roomId == '') {
          // 還沒建立聊天室 不用新增
          return;
        }
        if (_chatMsgNotifier.msgData.roomId == viewModel.roomId) {
          // if ((_chatMsgNotifier.msgData.memberId == sMyID) ||
          //     (_chatMsgNotifier.msgData.memberId == _chatroomDetailData.chatMemberId)) {
          // 確認是當前聊天室的訊息
          showingList.insert(0, _chatMsgNotifier.msgData); // insert單則訊息
          GlobalData.printLog('_chatMsgNotifier的資料：' + _chatMsgNotifier.msgData.message);
          setState(() {});
          // }
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant PrivateMessagePage oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: CustomAppBar.chatRoomAppBar(context, nickName: friendName, avatar: viewModel.rebeccaImg),
      body: (isDark) => Container(
        width: UIDefine.getWidth(),
        decoration: BoxDecoration(gradient: AppColors.messageLinearBg),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(decoration: BoxDecoration(gradient: AppColors.messageLinearBg)),
            Column(
              children: [
                // Consumer(
                //   builder: (context, watch, child) {
                //     final list = ref.watch(listImgNotiferProvider.notifier).state;
                //     return list.length.
                //     ListView.builder(
                //       itemCount: imgList.length,
                //       itemBuilder: (context, index) {
                //         final item = imgList[index];
                //         return
                //       },
                //     );
                //   },
                // ),

                //   child: viewModel.showImageWall
                //       ? viewModel.imageList.isEmpty
                //           ? Container()
                //           : Container(
                //               height: UIDefine.getPixelHeight(100),
                //               child: ListView.builder(
                //                 itemCount: viewModel.imageList.length,
                //                 itemBuilder: (context, index) {
                //                   final image = imageList[index];
                //                   return Container(
                //                     color: Colors.blue,
                //                     child: Text("test"),
                //                   );
                //                 },
                //               ),
                //             )
                //       : Container(),
                // ),
                // viewModel.showImageWall
                //     ? Container(
                //         height: UIDefine.getPixelHeight(100),
                //         child:
                //         ListView.builder(
                //           itemCount: ref.read(listImgNotiferProvider.notifier).state.length,
                //           itemBuilder: (context, index) {
                //             final image = imageList[index];
                //             return Container(
                //               color: Colors.blue,
                //               child: Text("test"),
                //             );
                //           },
                //         ),
                //       )
                // : Container(),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(chatRoomProvider);
                    return Expanded(
                      child: Container(
                        child: _buildListView(),
                      ),
                    );
                  },
                ),
                _getBottomTextField(),
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
                                    child: Container(width: UIDefine.getWidth(), child: RecorderView()),
                                  )
                                ],
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 0,
                          )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _getBottomTextField() {
    return Container(
      height: showGallery || showRecorder ? UIDefine.getHeight() * 0.08 : null,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Color(0xFF18100C), boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 1,
          spreadRadius: 0,
          offset: Offset(0, 0),
        )
      ]),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: viewModel.textFocusNode,
              controller: viewModel.textController,
              style: AppTextStyle.getBaseStyle(color: AppColors.textWhite, fontSize: UIDefine.fontSize12),
              maxLines: viewModel.isFocus ? 5 : 1,
              minLines: 1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(40)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(40)),
                hintText: tr('writeAMessage'),
                hintStyle: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12, color: AppColors.textHintColor),
                fillColor: Color(0xFF292322),
                filled: true,
                suffixIcon: viewModel.isFocus
                    ? GestureDetector(
                        onTap: () {
                          GlobalData.printLog("send");
                          viewModel.onSendMessage(viewModel.textController.text, false, "TEXT");
                        },
                        child: Icon(Icons.send))
                    : GestureDetector(
                        onTap: () {
                          _onTapMicrophone();
                        },
                        child: Image.asset(
                          AppImagePath.microphoneIcon,
                          color: showRecorder ? Colors.blue : AppColors.textWhite.getColor(),
                        ),
                      ),
                prefixIcon: viewModel.isFocus
                    ? null
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: AppColors.buttonCameraBg.light,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              border: Border.all(color: AppColors.buttonCameraBg.dark, width: 1)),
                          child: InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.photo_camera,
                              color: AppColors.textWhite.light,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(
            width: UIDefine.getPixelWidth(19),
          ),
          viewModel.isFocus
              ? Container()
              : InkWell(
                  onTap: () {
                    _openGallery();
                  },
                  child: Icon(
                    Icons.photo,
                    color: AppColors.textWhite.light,
                  ),
                ),
          viewModel.isFocus ? Container() : SizedBox(width: UIDefine.getPixelWidth(10)),
          viewModel.isFocus
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(right: UIDefine.getPixelWidth(10)),
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.add,
                      color: AppColors.textWhite.light,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  _getBottomNavigationBar() {
    return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
            height: showGallery || showRecorder ? UIDefine.getHeight() * 0.4 : UIDefine.getPixelWidth(40),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(right: UIDefine.getPixelWidth(8), bottom: UIDefine.getPixelWidth(5)),
                    width: UIDefine.getWidth(),
                    height: 300,
                    // height: UIDefine.getPixelWidth(40),
                    decoration: BoxDecoration(color: AppColors.dialogBackground.getColor(), boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1,
                        spreadRadius: 0,
                        offset: Offset(0, 0),
                      )
                    ]),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              focusNode: viewModel.textFocusNode,
                              controller: viewModel.textController,
                              style: AppTextStyle.getBaseStyle(
                                  color: AppColors.buttonPrimaryText, fontSize: UIDefine.fontSize12),
                              maxLines: 5,
                              minLines: 1,
                              decoration: InputDecoration(
                                // isDense: true,
                                border: InputBorder.none,
                                hintText: tr('writeAMessage'),
                                hintStyle: AppTextStyle.getBaseStyle(
                                    fontSize: UIDefine.fontSize12, color: AppColors.textPrimary),
                                fillColor: AppColors.bolderGrey.getColor(),
                                filled: true,
                                suffixIcon: viewModel.isFocus
                                    ? GestureDetector(
                                        onTap: () {
                                          viewModel.onSendMessage(viewModel.textController.text, false, "TEXT");
                                        },
                                        child: Icon(Icons.send))
                                    : GestureDetector(
                                        onTap: () {
                                          _onTapMicrophone();
                                        },
                                        child: Image.asset(
                                          AppImagePath.microphoneIcon,
                                          color: showRecorder ? Colors.blue : AppColors.textWhite.getColor(),
                                        ),
                                      ),
                                prefixIcon: InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.photo_camera,
                                      color: AppColors.textWhite.light,
                                    )),
                              ),
                            ),
                          ),

                          // Container(
                          //   padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
                          //   width: UIDefine.getWidth() * 0.85,
                          //   // height: UIDefine.getPixelWidth(40),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(14),
                          //     color: AppColors.dialogBackground.getColor(),
                          //   ),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       ///工具列
                          //       SizedBox(width: UIDefine.getPixelWidth(10)),
                          //       Expanded(
                          //         child: Container(
                          //           // width: UIDefine.getPixelWidth(180),
                          //           // height: UIDefine.getPixelWidth(40),
                          //           child: Column(
                          //             children: [
                          //
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //
                          //
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
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

  Widget _buildListView() {
    return RectGetter(
      key: listViewKey,
      child: ListView.builder(
          reverse: true, // 倒序
          itemCount: showingList.length,
          itemBuilder: (context, index) {
            _keys[index] = RectGetter.createGlobalKey();
            return RectGetter(
              key: _keys[index],
              child: Padding(
                padding: index == showingList.length - 1
                    ? EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(1),
                        UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(0.5))
                    : EdgeInsets.fromLTRB(UIDefine.getScreenWidth(1), UIDefine.getScreenWidth(0.5),
                        UIDefine.getScreenWidth(1), UIDefine.getScreenWidth(0.5)),
                child: _getTalkView(index),
              ),
            );
          }),
    );
  }

  Widget _getTalkView(int index) {
    if (showingList[index].timestamp == 0) {
      // 空值為顯示日期的View
      return Container(
        padding: const EdgeInsets.all(5),
        margin: EdgeInsets.only(right: UIDefine.getScreenWidth(28), left: UIDefine.getScreenWidth(28)),
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), color: Colors.blue),
        child: Text(
          _getDateFormat(index - 1),
          style: TextStyle(color: Colors.yellow, fontSize: UIDefine.fontSize12),
        ),
      );
    } else {
      // bool bMe = showingList[index].receiverAvatarId == GlobalData.selfAvatar;
      return showingList[index].receiverAvatarId != GlobalData.selfAvatar.toString()
          ? MessageViewForSelf(
              index: index,
              bGroup: false,
              bOnLongPress: false, //先false
              data: showingList[index],
              roomDetailData: _chatroomDetailData,
            )
          : MessageViewForOther(
              index: index,
              bGroup: false,
              bOnLongPress: false,
              data: showingList[index],
            );
    }
  }

  /// 取時間為 西元年月日
  String _getDateFormat(int index) {
    if (showingList.isNotEmpty) {
      String sTime = showingList[index].timestamp.toString();
      if (sTime != '') {
        DateTime dateTime = DateTime.parse(sTime);
        sTime = DateFormat('yyyy-MM-dd').format(dateTime);
        return sTime;
      }
    }
    return '';
  }

  void _getDbDataToShow() {
    Future<List<ChatHistorySQLite>> list = ChatHistoryDB.getHistory(3);
    list.then((value) => _reverseList(value));
  }

  Future<void> _reverseList(List<ChatHistorySQLite> tempList) async {
    showingList = tempList.reversed.toList();
    setState(() {});
  }

  // void _setUserData() {
  //   userData.memberId = _chatroomDetailData.chatMemberId;
  //   userData.nickname = _chatroomDetailData.chatNickName;
  //   userData.userId = _chatroomDetailData.chatUid;
  //   userData.avatar = _chatroomDetailData.chatAvatar;
  //   userData.mark = _chatroomDetailData.chatMemberMark;

  //   ChatroomListSQLiteData dbData = ChatroomListSQLiteData();
  //   dbData.roomId = roomId;
  //   dbData.roomType = 'single';
  //   dbData.blockStatus = _chatroomDetailData.blockStatus;
  //   dbData.chatMemberMark = _chatroomDetailData.chatMemberMark;
  //   dbData.uId = _chatroomDetailData.chatUid;
  //   dbData.avatar = _chatroomDetailData.chatAvatar;
  //   dbData.memberId = _chatroomDetailData.chatMemberId;
  //   dbData.readTimeStatus = _chatroomDetailData.readTimeStatus;
  //   ChatroomListDB.updateChatRoomDetail(dbData);

  //   bReadTimeStatus = _chatroomDetailData.readTimeStatus == 'enable';

  //   setState(() {});
  // }
}
