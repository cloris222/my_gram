import 'package:base_project/constant/theme/app_gradient_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/utils/date_format_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constant/theme/app_colors.dart';
import '../../../views/message/sqlite/data/chat_history_sqlite.dart';
import 'package:base_project/constant/theme/global_data.dart';
import '../../../constant/theme/ui_define.dart';
import '../../../views/message/data/message_chatroom_detail_response_data.dart';
import '../../../widgets/play_audio_bubble.dart';

class MessageViewForSelf extends ConsumerStatefulWidget {
  MessageViewForSelf({
    super.key,
    required this.index,
    required this.bGroup,
    required this.bOnLongPress,
    required this.data,
    required this.roomDetailData,
    // required this.messageActionCallBack,
    // required this.clickImageCallBack,
  });

  final int index;
  final bool bGroup;
  final ChatHistorySQLite data;
  final MessageChatroomDetailResponseData roomDetailData;
  // final Function messageActionCallBack;
  // final Function clickImageCallBack;
  bool bOnLongPress;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageViewForSelf();
}

class _MessageViewForSelf extends ConsumerState<MessageViewForSelf> with TickerProviderStateMixin {
  bool bReply = false;

  ChatHistorySQLite get data {
    return widget.data;
  }

  @override
  void initState() {
    super.initState();

    bReply = data.action == 'messageReply';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: UIDefine.getPixelHeight(3)),
      child: Stack(
        children: [
      // 時間+對話框框
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
              color: Colors.transparent,
                child: Text(
                    // DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(int.parse(data.timestamp))),
                  DateFormatUtil().timeStamptoDate(data.timestamp),
                  style: AppTextStyle.getBaseStyle(
                    color: AppColors.commentUnlike,
                    fontSize: UIDefine.fontSize10),
                ),
              ),
              SizedBox(width: 8),
              Container(
                child: _getMyTalkBubble(bReply, data),
              )
            ],
          ),
        ],
      ),
    );
  }

  /// 自己的泡泡
  Widget _getMyTalkBubble(bool bReply, ChatHistorySQLite data) {
    return Container(
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
          gradient: LinearGradient(colors: AppGradientColors.gradientBaseColorBg.getColors())
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          UIDefine.getPixelWidth(10),
          UIDefine.getPixelHeight(7),
          UIDefine.getPixelWidth(10),
          UIDefine.getPixelHeight(7)),
        // ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: UIDefine.getPixelWidth(160)),
          child: data.msgType == "TEXT"?
          Text(
            data.content.replaceAll(' ', ''),
            style: AppTextStyle.getBaseStyle(
              color: AppColors.textBlack,
              fontSize: UIDefine.fontSize15)
            // TextStyle(
              
            //   height: 1.5,
            //   color: AppColors.textBlack.dark,
            //   fontSize: UIDefine.fontSize15),
          ):PlayAudioBubble(path: "${GlobalData.urlPrefix}${data.content}",bSelf: true,contentId: data.contentId,),
        )),
    );
  }
}
