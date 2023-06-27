import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import '../../../constant/theme/ui_define.dart';
import '../../../../constant/theme/app_colors.dart';
import '../../../views/message/sqlite/data/chat_history_sqlite.dart';

class MessageViewForUpdating extends ConsumerStatefulWidget {
  const MessageViewForUpdating({super.key,
  required this.data,
  });

  final ChatHistorySQLite data;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageViewForUpdating();
}

class _MessageViewForUpdating extends ConsumerState<MessageViewForUpdating> with TickerProviderStateMixin {

  ChatHistorySQLite get data {
    return widget.data;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.only(
          right: UIDefine.getScreenWidth(21),
          left: UIDefine.getScreenWidth(21)),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppColors.chatBubbleColor.dark),
      child: Text(
        _getUpdateContent(),
        style: TextStyle(
            color: AppColors.messageBackground.light, fontSize: UIDefine.fontSize10),
      ),
    );
  }

  String _getUpdateContent() {
    // switch(data.action) {
    //   case 'memberUid': // 會員改Uid
    //     return format(
    //         tr('Change_UID'),
    //         {'oldUid': data.beforeValue, 'NewUid': data.afterValue});

    //   case 'memberAvatar': // 會員改頭像
    //     return format(
    //         tr('changed_avatar'),
    //         {'Uid': data.operatorUid});

    //   case 'groupName': // 改群組名稱
    //     return format(
    //         tr('changed_groupName'),
    //         {'Uid': data.operatorUid, 'NewGroupName': data.afterValue});

    //   case 'groupImg': // 改群組照片
    //     return format(
    //         tr('ChangeGroup_Picture'),
    //         {'Uid': data.operatorUid});

    //   case 'addToGroup': // 進群組
    //     if (data.operator == data.memberId) { // 自己透過QRCode加入群組
    //       return format(
    //           tr('joined_the_group'),
    //           {'Uid': data.operatorUid});
    //     }
    //     return format( // A+B進群組
    //         tr('add_in_group'),
    //         {'UidA': data.operatorUid, 'UidB': data.uid});

    //   case 'withdrawFromGroup': // 退群組
    //     if (data.operatorUid == data.uid) { // 自己退出
    //       return format(
    //           tr('leave_group'),
    //           {'Uid': data.operatorUid});
    //     }
    //     return format( // A踢B
    //         tr('kicked_out'),
    //         {'UidA': data.operatorUid, 'UidB': data.uid});

    //   case 'groupPermission': // 更改群組權限
    //     if (data.operatorUid == data.uid) { // 將自己設為一般會員
    //       return format(
    //           tr('turns_generalMember'),
    //           {'Uid': data.operatorUid});
    //     }
    //     if (data.afterValue == 'silence') {
    //       return format(
    //           tr('ban'),
    //           {'UidA': data.operatorUid, 'UidB': data.uid});
    //     }
    //     return format(
    //         tr('turns_administrator'),
    //         {'UidA': data.operatorUid, 'UidB': data.uid});

    //   case 'groupType': // 目前沒有
    //     return '';
    // }
    return '';
  }

}