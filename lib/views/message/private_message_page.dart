import 'dart:async';

import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_gradient_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_gradient_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/models/app_shared_preferences.dart';
import 'package:base_project/models/http/data/dynamic_info_data.dart';
import 'package:base_project/utils/pitch_data_util.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/views/message/recorder_view.dart';
import 'package:base_project/view_models/message/websocketdata/ws_send_message_data.dart';
import 'package:base_project/views/message/sqlite/chat_history_db.dart';
import 'package:base_project/views/message/widget/message_view_for_other.dart';
import 'package:base_project/widgets/label/avatar_icon_widget.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
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
import '../../widgets/label/loading_widget.dart';
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

class _PrivateMessagePageState extends ConsumerState<PrivateMessagePage> with TickerProviderStateMixin{
  late MessagePrivateGroupMessageViewModel viewModel;
  bool showGallery = false;
  bool sendImage = false;
  String friendName = "Rebecca";
  bool bScrolling = false;
  String sMyID = GlobalData.userMemberId;
  String currentShowingDate = '';
  StateSetter? dateViewSetState; // 漂浮日期View的獨立setState
  int lastVisibleIndex = 0; // 螢幕上顯示的最後一個view
  bool test = false;
  ChatHistorySQLite replyByMessageData = ChatHistorySQLite();
  MessageChatroomDetailResponseData _chatroomDetailData = MessageChatroomDetailResponseData();

  var listViewKey = RectGetter.createGlobalKey(); // 聊天訊息的ListView Key
  List<ChatHistorySQLite> showingList = []; // 顯示雙方訊息用的DataList
  var _keys = {}; // ListItem的key集合
  late PermissionState ps = PermissionState.notDetermined;
  late ChatMsgNotifier _chatMsgNotifier; // 訊息之Notifier
  List<AssetEntity> get imageList => ref.read(chatRoomProvider);
  List<AssetEntity> showImageList = [];

  List<String> get readList => ref.watch(readListProvider);

  // bool showRecorder = false;

  @override
  initState() {
    // Future.delayed(Duration.zero,()async{
    //   final prefix = await viewModel.getFilePrefix();
    // });
    viewModel = MessagePrivateGroupMessageViewModel(ref);
    viewModel.textFocusNode.addListener(() {
      setState(() {
        viewModel.isFocus = viewModel.textFocusNode.hasFocus;
        if (viewModel.isFocus == true) {
          // ref.read(showRecordProvider.notifier).update((state) => false);
          if (ref.watch(showImageWallProvider)) {
            /// 若鍵盤彈起收起來
            viewModel.changeImgWallState(false);
          }
        }
      });
    });
    viewModel.checkImgWall();
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
      onTap: () => viewModel.onTapMicrophone(true),
      appBar: CustomAppBar.chatRoomAppBar(ref, context, nickName: friendName, avatar: viewModel.rebeccaImg),
      body: (isDark) => Container(
        width: UIDefine.getWidth(),
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(AppImagePath.gradientBg), fit: BoxFit.fill)),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(decoration: BoxDecoration(gradient: AppColors.messageLinearBg)),
            Column(
              children: [
                ref.watch(showImageWallProvider)
                    ? Consumer(
                        builder: (context, watch, child) {
                          final imgList = ref.watch(imgListProvider);
                          return imgList.length == 0
                              ? Container()
                              : Stack(
                                  children: [
                                    Container(
                                      height: UIDefine.getPixelHeight(110),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: imgList.length,
                                        itemBuilder: (context, index) {
                                          // final item = imgList[index];
                                          return GestureDetector(
                                            onTap: () => viewModel.onShowSelfDynamic(context, index),
                                            behavior: HitTestBehavior.translucent,
                                            child: Container(
                                              color: Colors.blue,
                                              child: Image.asset(imgList[index]),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                        },
                      )
                    : Container(),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(chatRoomProvider);
                    return Expanded(
                      // child: NotificationListener<ScrollNotification>(
                      //   onNotification: (notification) {
                      //     _updateDateViewByIndex();
                      //     if (notification is ScrollStartNotification) {
                      //       dateViewSetState!(() {
                      //         bScrolling = true;
                      //       });
                      //     }
                      //     if (notification is ScrollEndNotification) {
                      //       dateViewSetState!(() {
                      //         bScrolling = false;
                      //       });
                      //     }
                      //     return true;
                      //   },
                      child: Row(
                        children: [
                          Expanded(child: _buildListView()),
                        ],
                      ),
                      // ),
                    );
                  },
                ),
              ],
            ),
            Positioned(
                bottom: UIDefine.getNavigationBarHeight(),
              // bottom: UIDefine.getNavigationBarHeight() - 0.1,
              child: Column(
                children: [
                  _getBottomTextField(),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: ref.watch(showRecordProvider)?UIDefine.getPixelWidth(270):0.0,
                    width: UIDefine.getWidth(),
                    child: const RecorderView(),
                  ),
                  // Visibility(
                  //   visible: ref.watch(showRecordProvider),
                  //   child: AnimatedContainer(
                  //     duration: const Duration(milliseconds: 1000),
                  //     curve: Curves.easeInOut,
                  //     height: ref.watch(showRecordProvider)?UIDefine.getPixelWidth(270):0.0,
                  //     width: UIDefine.getWidth(),
                  //     child:  const RecorderView(),
                  //   ),
                  // ),
                ],
              ),
            ),
            ref.watch(showImageWallProvider)
                ? Positioned(
                    top: UIDefine.getPixelHeight(118),
                    child: GestureDetector(
                      child: Container(child: Image.asset(AppImagePath.closeWallButton)),
                      onTap: () {
                        bool open = false;
                        viewModel.changeImgWallState(open);
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  _getBottomTextField() {
    return GlassContainer(
      width: UIDefine.getWidth(),
      border: 0.0,
      blur: 8,
      radius: 0,
      linearGradient: LinearGradient(colors: [AppColors.mainBackground.getColor().withOpacity(0.8), AppColors.mainBackground.getColor().withOpacity(0.8)]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 5, 0, 5.1),
        child: Row(
          children: [
            Expanded(
              child: Container(
                // alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(
                    viewModel.isFocus ? UIDefine.getPixelWidth(15) : UIDefine.getPixelWidth(3),
                    viewModel.isFocus ? UIDefine.getPixelWidth(5) : UIDefine.getPixelWidth(2),
                    viewModel.isFocus ? UIDefine.getPixelWidth(12) : UIDefine.getPixelWidth(3),
                    viewModel.isFocus ? UIDefine.getPixelWidth(5) : UIDefine.getPixelWidth(2)),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color(0xFF292322)),
                child: Row(
                  crossAxisAlignment: viewModel.isFocus ? CrossAxisAlignment.end : CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: UIDefine.getPixelWidth(viewModel.isFocus ? 0 : 8)),
                      child: viewModel.isFocus
                          ? Container()
                          : Container(
                              height: UIDefine.getPixelWidth(36),
                              width: UIDefine.getPixelWidth(36),
                              padding: EdgeInsets.all(UIDefine.getPixelWidth(4)),
                              decoration: BoxDecoration(
                                  color: AppColors.buttonCameraBg.light,
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  border: Border.all(color: AppColors.buttonCameraBg.dark, width: 0.5)),
                              child: InkWell(onTap: () {}, child: Image.asset(AppImagePath.icCamera)),
                            ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (ref.read(showRecordProvider)) {
                            ref.read(showRecordProvider.notifier).update((state) => false);
                            Future.delayed(const Duration(milliseconds: 100)).then((value) {
                              FocusScope.of(context).requestFocus(viewModel.textFocusNode);
                            });
                          }
                        },
                        child: TextField(
                          textAlign: TextAlign.start,
                          focusNode: viewModel.textFocusNode,
                          controller: viewModel.textController,
                          style: AppTextStyle.getBaseStyle(color: AppColors.textWhite, fontSize: UIDefine.fontSize15, overflow: TextOverflow.ellipsis),
                          maxLines: viewModel.isFocus ? 5 : 1,
                          minLines: 1,
                          enabled: !ref.watch(showRecordProvider),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: viewModel.isFocus ? UIDefine.getPixelWidth(8) : 0),
                            // contentPadding: EdgeInsets.zero,
                            isDense: true,
                            // isCollapsed: true,
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(40)),
                            hintText: 'writeAMessage'.tr(),
                            hintStyle: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize15, color: AppColors.textHintColor),
                            fillColor: Colors.transparent,
                            filled: true,
                          ),
                        ),
                      ),
                    ),
                    viewModel.isFocus
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(UIDefine.getPixelWidth(10), UIDefine.getPixelHeight(0), UIDefine.getPixelWidth(0), UIDefine.getPixelHeight(0)),
                            child: Container(
                              // color: Colors.red,
                              // height: UIDefine.getPixelWidth(24),
                              // width: UIDefine.getPixelWidth(24),
                              child: GestureDetector(
                                  onTap: () {
                                    viewModel.onSendMessage(viewModel.textController.text, false, "TEXT");
                                  },
                                  child: Image.asset(AppImagePath.sendIcon)),
                            ),
                          )
                        : viewModel.textController.text.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.fromLTRB(UIDefine.getPixelWidth(13), UIDefine.getPixelHeight(2), UIDefine.getPixelWidth(8), UIDefine.getPixelHeight(2)),
                                child: Container(
                                  // height: UIDefine.getPixelWidth(24),
                                  // width: UIDefine.getPixelWidth(24),
                                  child: GestureDetector(
                                      onTap: () {
                                        viewModel.onSendMessage(viewModel.textController.text, false, "TEXT");
                                      },
                                      child: Image.asset(AppImagePath.sendIcon)),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.fromLTRB(UIDefine.getPixelWidth(3), UIDefine.getPixelHeight(2), UIDefine.getPixelWidth(3), UIDefine.getPixelHeight(2)),
                                child: Container(
                                  width: UIDefine.getPixelWidth(24),
                                  child: GestureDetector(
                                    onTap: () {
                                      viewModel.onTapMicrophone(false);
                                      // _onTapMicrophone();
                                    },
                                    child: Image.asset(
                                      AppImagePath.microphoneIcon,
                                      color: ref.watch(showRecordProvider) ? Colors.blue : AppColors.textWhite.getColor(),
                                    ),
                                  ),
                                ),
                              ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: viewModel.isFocus ? 0 : UIDefine.getPixelWidth(16),
            ),
            viewModel.isFocus
                ? Container()
                : InkWell(
                    onTap: () {
                      // _openGallery();
                    },
                    child: Image.asset(AppImagePath.photoIcon)),
            viewModel.isFocus ? Container() : SizedBox(width: UIDefine.getPixelWidth(16)),
            viewModel.isFocus
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(right: UIDefine.getPixelWidth(16)),
                    child: InkWell(onTap: () {}, child: Image.asset(AppImagePath.addIcon)),
                  ),
          ],
        ),
      ),
    );
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

  Future<void> _sendImage() async {
    setState(() {
      showImageList.addAll(imageList);
    });
  }

  Widget _buildListView() {
    return RectGetter(
      key: listViewKey,
      child: ListView.builder(
          padding: EdgeInsets.only(bottom: UIDefine.getNavigationBarHeight() + UIDefine.getPixelWidth(viewModel.isFocus ? 56 : 52)+UIDefine.getPixelWidth(ref.watch(showRecordProvider)?270:0)),
          reverse: true, // 倒序
          itemCount: readList.isNotEmpty ? showingList.length + 1 : showingList.length,
          itemBuilder: (context, index) {
            if (readList.isNotEmpty) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(1), UIDefine.getScreenWidth(0.5), UIDefine.getScreenWidth(1), UIDefine.getScreenWidth(0.5)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: UIDefine.getPixelHeight(5)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "assets/icon/pitch/pair/01.Rebecca_01_01.png",
                            width: UIDefine.getPixelWidth(30),
                            height: UIDefine.getPixelHeight(30),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(UIDefine.getScreenWidth(1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: UIDefine.getPixelWidth(8),
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                                  gradient: LinearGradient(colors: AppGradientColors.gradientOtherMessage.getColors())),
                              child: _getOthersTalkBubble(),
                            ),
                            SizedBox(width: UIDefine.getPixelWidth(8)),
                            Text(
                              tr('typing'),
                              style: TextStyle(color: AppColors.commentUnlike.light, fontSize: UIDefine.fontSize10, fontWeight: FontWeight.w400, letterSpacing: 0.4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }

            int realIndex=index-(readList.isNotEmpty?1:0);
            var key = showingList[realIndex].contentId;
            _keys[key] = _keys[key] ?? RectGetter.createGlobalKey();
            return RectGetter(
              key: _keys[key],
              child: Padding(
                padding: realIndex == showingList.length - 1 ? EdgeInsets.fromLTRB(
                  UIDefine.getPixelWidth(8),
                UIDefine.getPixelWidth(1),
                UIDefine.getPixelWidth(8),
                UIDefine.getPixelWidth(0.5))
                : showingList[realIndex].receiverAvatarId != showingList[realIndex+1].receiverAvatarId ? EdgeInsets.fromLTRB(
            UIDefine.getPixelWidth(6),
            UIDefine.getPixelWidth(24),
            UIDefine.getPixelWidth(6),
            UIDefine.getPixelWidth(0.5))
                : EdgeInsets.fromLTRB(
            UIDefine.getPixelWidth(6),
            UIDefine.getPixelWidth(0),
            UIDefine.getPixelWidth(6),
            UIDefine.getPixelWidth(0)),
                child: _getTalkView(realIndex),
              ),
            );
          }),
    );
  }

  Widget _getTalkView(int index) {
    if (showingList[index].timestamp.isEmpty) {
      // 空值為顯示日期的View
      return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(right: UIDefine.getScreenWidth(28), left: UIDefine.getScreenWidth(28)),
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)), color: Colors.blue),
        child: Text(
          _getDateFormat(index - 1),
          style: TextStyle(color: Colors.yellow, fontSize: UIDefine.fontSize12),
        ),
      );
    }

    // if (showingList.length > index + 1) {
    //   if (showingList[index + 1].timestamp.isNotEmpty) {
    //     bool nextSameDate =
    //         DateFormatUtil().compareSameDay(showingList[index].timestamp, showingList[index + 1].timestamp);

    //     if (!nextSameDate) {
    //       showingList.insert(index + 1, ChatHistorySQLite());
    //     }
    //   }
    // }
    // bool bMe = showingList[index].receiverAvatarId == GlobalData.selfAvatar;
    return showingList[index].receiverAvatarId != GlobalData.selfAvatar.toString()
        ? MessageViewForSelf(
            key: ValueKey(showingList[index].contentId),
            index: index,
            bGroup: false,
            bOnLongPress: false,
            //先false
            data: showingList[index],
            roomDetailData: _chatroomDetailData,
          )
        : MessageViewForOther(
            key: ValueKey(showingList[index].contentId),
            index: index,
            bGroup: false,
            bOnLongPress: false,
            data: showingList[index],
          );
  }

  void _updateDateViewByIndex() {
    var rect = RectGetter.getRectFromKey(listViewKey);
    var items = <int>[];
    _keys.forEach((index, key) {
      var itemRect = RectGetter.getRectFromKey(key);
      if (itemRect != null && !(itemRect.top > rect!.bottom || itemRect.bottom < rect.top)) {
        items.add(index);
      }
    });

    lastVisibleIndex = items.last;
    if (currentShowingDate == _getDateFormat(lastVisibleIndex)) {
      return;
    } else {
      currentShowingDate = _getDateFormat(lastVisibleIndex);
      dateViewSetState!(() {});
    }
  }

  // onTapMicrophone() async{
  //   setState(() {
  //     showRecorder = !showRecorder;
  //   });
  // }

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
    int intRoom = int.parse(viewModel.roomId);
    Future<List<ChatHistorySQLite>> list = ChatHistoryDB.getHistory(intRoom);
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

  Widget _getOthersTalkBubble() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          gradient: LinearGradient(colors: AppGradientColors.gradientOtherMessage.getColors())),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(10), vertical: UIDefine.getPixelWidth(8)),
        child: ConstrainedBox(constraints: BoxConstraints(maxWidth: UIDefine.getScreenWidth(50)), child: const LoadingWidget()),
      ),
    );
    // IntrinsicWidth(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       // ConstrainedBox(
    //       //   constraints: BoxConstraints(
    //       //       maxWidth: UIDefine.getScreenWidth(50)),
    //       // ),
    //       ConstrainedBox(
    //           constraints: BoxConstraints(maxWidth: UIDefine.getScreenWidth(48)),
    //           child: data.msgType == "TEXT"
    //               ? Text(
    //                   data.content,
    //                   style: TextStyle(color: AppColors.textWhite.light, fontSize: UIDefine.fontSize14),
    //                 )
    //               : PlayAudioBubble(
    //                   path: "${GlobalData.urlPrefix}${data.content}",
    //                   bSelf: false,
    //                   contentId: data.contentId,
    //                 ))
    //     ],
    //   ),
    // );
  }
}
