import 'package:base_project/constant/theme/app_gradient_colors.dart';
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
        Padding(
          padding: EdgeInsets.all(UIDefine.getScreenWidth(1.5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                  gradient: LinearGradient(colors: AppGradientColors.gradientOtherMessage.getColors())
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    UIDefine.getScreenWidth(3),
                    UIDefine.getScreenWidth(1.5),
                    UIDefine.getScreenWidth(3),
                    UIDefine.getScreenWidth(1.5),
                  ),
                      child: _getOthersTalkBubble(),
                ),
              ),
              SizedBox(width: 4),
              Container(
              color: Colors.transparent,
                child: Text(
                  DateFormatUtil().timeStamptoDate(data.timestamp),
                  style: TextStyle(
                    color: AppColors.commentUnlike.light,
                    fontSize: UIDefine.fontSize8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 別人的泡泡 
  Widget _getOthersTalkBubble() {
      return IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: UIDefine.getScreenWidth(50)),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: UIDefine.getScreenWidth(48)),
              child: data.msgType == "TEXT"?
              Text(
                data.content,
                style: TextStyle(
                  color: AppColors.textWhite.light,
                  fontSize: UIDefine.fontSize16),
              ):SizedBox(width: 10,)
            )
          ],
        ),
      );
  }
}