import 'package:base_project/constant/theme/app_gradient_colors.dart';
import 'package:base_project/utils/date_format_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/global_data.dart';
import '../../../constant/theme/app_text_style.dart';
import '../../../constant/theme/ui_define.dart';
import '../../../widgets/play_audio_bubble.dart';
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

enum MessageAction { Copy, Reply, Share, Report, Recall, Emoji }

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
    return Padding(
      padding:  EdgeInsets.only(top: UIDefine.getPixelHeight(3)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: UIDefine.getPixelHeight(5),left: UIDefine.getPixelWidth(0),right: UIDefine.getPixelWidth(6)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                "assets/icon/pitch/pair/01.Rebecca_01_01.png",
                width: UIDefine.getPixelWidth(32),
                height: UIDefine.getPixelWidth(32),
                fit: BoxFit.cover,
              ),
              // child: CachedNetworkImage(
              //   imageUrl: GlobalData.urlPrefix + data.replyByAvatar,
              // width: UIDefine.getScreenWidth(7.5),
              // height: UIDefine.getScreenWidth(7.5),
              //   fit: BoxFit.cover,
              //   memCacheWidth: (UIDefine.getWidth() * 0.5).toInt(),
              // )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // SizedBox(
              //   width: UIDefine.getPixelWidth(8),
              // ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                    gradient: LinearGradient(colors: AppGradientColors.gradientOtherMessage.getColors())),
                child: _getOthersTalkBubble(),
              ),
              SizedBox(width: 4),
              Text(
                // DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(int.parse(data.timestamp))),
                DateFormatUtil().timeStamptoDate(data.timestamp),
                style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize10,
                color: AppColors.commentUnlike),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 別人的泡泡
  Widget _getOthersTalkBubble() {
    return Container(
      // alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          gradient: LinearGradient(colors: AppGradientColors.gradientOtherMessage.getColors())),
      child: Container(
        padding: EdgeInsets.fromLTRB(
          UIDefine.getPixelWidth(10),
          UIDefine.getPixelHeight(7),
          UIDefine.getPixelWidth(10),
          UIDefine.getPixelHeight(7),),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: UIDefine.getPixelWidth(160)),
          child: data.msgType == "TEXT"?
          Container(
            child: Text(
              data.content.replaceAll(' ', ''),
              style: AppTextStyle.getBaseStyle(
                color: AppColors.textWhite,
                fontSize: UIDefine.fontSize15)
              // TextStyle(
              //   height: 1.5,
              //   color: AppColors.textWhite.light, fontSize: UIDefine.fontSize15),
            ),
          )
          : PlayAudioBubble(
            path: "${GlobalData.urlPrefix}${data.content}",
            bSelf: false,
            contentId: data.contentId,
          ),
        ),
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
