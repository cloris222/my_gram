import 'package:base_project/utils/date_format_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/global_data.dart';
import '../../../constant/theme/ui_define.dart';
import '../sqlite/data/chat_history_sqlite.dart';

class MessageViewForOther extends ConsumerStatefulWidget {
  MessageViewForOther({
  super.key,
  required this.index,
  required this.bGroup,
  required this.bOnLongPress,
  required this.data,
  // required this.userData,
  // required this.messageActionCallBack,
  // required this.clickImageCallBack,
  // required this.clickAvatarCallBack,
  });

  final int index;
  final bool bGroup;
  final ChatHistorySQLite data;
  // final UserInfoData userData;
  // final Function messageActionCallBack;
  // final Function clickImageCallBack;
  // final Function clickAvatarCallBack;
  bool bOnLongPress;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageViewForOthers();
}

enum MessageAction{Copy, Reply, Share, Report, Recall, Emoji}

class _MessageViewForOthers extends ConsumerState<MessageViewForOther> with TickerProviderStateMixin {

  bool bReply = false;
  bool bLast = true;

  ChatHistorySQLite get data {
    return widget.data;
  }

  @override
  void initState() {
    super.initState();

    // bReply = data.action == 'messageReply';
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onLongPress: () {
            // ref.read(longPressIndexProvider.notifier).update((state) => widget.index);
            // setState(() { widget.bOnLongPress = true; });
          },
          child: Padding(
            padding: EdgeInsets.all(UIDefine.getScreenWidth(1.5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  width: 4,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                      color: AppColors.otherBubbleMessage),
                  child: 
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        UIDefine.getScreenWidth(3),
                        UIDefine.getScreenWidth(1.5),
                        UIDefine.getScreenWidth(3),
                        UIDefine.getScreenWidth(1.5)),
                    child: Text(data.content),
                  ),
                ),
                // Container(
                //   width: 4,
                //   height: 5,
                //   child: Text(
                //     DateFormatUtil().getTimeFormat(data.timestamp),
                //     // "tesg",
                //     style: TextStyle(
                //         color: AppColors.iconPrimary.dark,
                //         fontSize: UIDefine.fontSize8),
                //   ),
                // )
                
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 別人的泡泡
  Widget _getOthersTalkBubble() {
    // if (_checkIsRecall()) {
    //   data.content = tr('gotRecallMsg');
    // }

    // if (bReply) {
    //   if (data.replyByMsg.isEmpty && data.replyById.isNotEmpty) {
    //     data.replyByMsg = tr('cantReadMsg');
    //   }
      return IntrinsicWidth(
        // 讓分隔線match_parent
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  UIDefine.getScreenWidth(0),
                  UIDefine.getScreenWidth(0),
                  UIDefine.getScreenWidth(0),
                  UIDefine.getScreenWidth(2.77)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ClipRRect(
                  //     borderRadius: BorderRadius.circular(100),
                  //     child: CachedNetworkImage(
                  //       imageUrl: GlobalData.urlPrefix + data.replyByAvatar,
                  //       width: UIDefine.getScreenWidth(7.5),
                  //       height: UIDefine.getScreenWidth(7.5),
                  //       fit: BoxFit.cover,
                  //       memCacheWidth: (UIDefine.getWidth() * 0.5).toInt(),
                  //     )
                  // ),
                  SizedBox(
                    width: UIDefine.getScreenWidth(2.5),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: UIDefine.getScreenWidth(50)),
                      ),
                      // ConstrainedBox(
                      //   constraints: BoxConstraints(maxWidth: UIDefine.getScreenWidth(48)),
                      //   child: Text(
                      //     data.replyByMsg,
                      //     style: TextStyle(
                      //         color: AppColors.textHint.light,
                      //         fontSize: UIDefine.fontSize16),
                      //   ),
                      // )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 1.5,
              color: Colors.white,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(
                    UIDefine.getScreenWidth(0),
                    UIDefine.getScreenWidth(2.77),
                    UIDefine.getScreenWidth(2.77),
                    UIDefine.getScreenWidth(0)),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: UIDefine.getScreenWidth(48)),
                  child: Text(
                    data.content,
                    style: TextStyle(
                        color: AppColors.textLink.dark,
                        fontSize: UIDefine.fontSize16),
                  ),
                )),
          ],
        ),
      );
    // } else {
    //   return Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [getContentMsgOrImage()],
    //   );
    // }
  }
}