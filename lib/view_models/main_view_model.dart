// import 'dart:convert';
// import 'dart:io';

// import 'package:easy_localization/easy_localization.dart';

// import '../utils/date_format_util.dart';
// import 'base_view_model.dart';
// import '../utils/fm_shared_Preferences.dart';
// import '../constant/theme/global_data.dart';
// import '../views/message/data/message_direct_request_message_response_data.dart';

// class MainViewModel extends BaseViewModel {
//   bool bDuoBaoEnabled = true;
//   String roomIdForCalling = '';
//   String contentIdForCalling = '';
//   // AgoraInfo agoraData = AgoraInfo();
//   // UserInfoData creatorInfo = UserInfoData(avatar: '');
//   // UserInfoData joinerInfo = UserInfoData(avatar: '');

//   Future<void> requestChatroomList() async {
//     // 從SP取出上次更新的時間
//     FmSharedPreferences.getChatroomListTime().then((value) {
//       _setListIntoDB(value);
//     });
//   }

//   Future<void> _setListIntoDB(String time) async {
//     /// 訊息列表+未讀訊息
//     await _getChatroomListResponse(1, 50000).then((value) async {
//       List<MessageDirectRequestMessageResponseData> chatroomList = value;
//       for (int i = 0; i < chatroomList.length; i++) {
//         bool bNeedDownload = DateFormatUtil().compareDateTime(chatroomList[i].lastChatRecord.createTime, time);
//         if (bNeedDownload) {
//           // 最新訊息時間比上次紀錄時間還晚 所以要打API同步
//           bool bGroup = chatroomList[i].roomType == 'group';
//           _compareTimeToUpdateHistory(chatroomList[i], bGroup);
//         }

//         // 將聊天列表存進DB
//         await ChatroomListDB.addHistory(_setChatroomListDbData(chatroomList[i]));

//         // 聊天列表存好後通知Notifier
//         // GlobalData.chatroomNotifier.notifier();
//       }
//     });
//     GlobalData.printLog('存完訊息+列表');

//     /// 未讀總數
//     ChatroomListDB.queryUnreadCountTotal('followed').then((iCountTotal) {
//       GlobalData.redDotNotifier.setFollowedForInit(iCountTotal); // 暫存好友未讀數總和
//     });
//     ChatroomListDB.queryUnreadCountTotal('none').then((iCountTotal) {
//       GlobalData.redDotNotifier.setNoneForInit(iCountTotal); // 暫存陌生未讀數總和
//     });

//     /// emoji回應記錄
//     await _getStickerReplyResponse(1, 10000, time, DateFormatUtil().getDateTimeStringNow()).then((value) async {
//       List<MessageStickerReplyResponseData> emojiList = value;
//       for (int i = 0; i < emojiList.length; i++) {
//         EmojiSQLite dbData = _setEmojiDbData(emojiList[i]);
//         // 新的emoji回應存進DB (新表情or取消表情)
//         await ChatHistoryDB.deleteEmojiHistory(dbData);
//         await ChatHistoryDB.addEmojiHistory(dbData);
//         // 如果剛好在聊天室內靠這更新 (聊天室進背景再打開時)
//         GlobalData.saveMsgNotifier.notifier();
//       }
//     });

//     /// 訊息收回紀錄
//     await _getRecallRecordResponse(1, 10000, time, DateFormatUtil().getDateTimeStringNow()).then((value) async {
//       List<MessageRecallRecordResponseData> recallList = value;
//       for (int i = 0; i < recallList.length; i++) {
//         await ChatHistoryDB.updateRecallMsg(recallList[i].contentId);
//         await ChatHistoryDB.updateRecallMsgForReply(recallList[i].contentId);
//       }
//       // 如果剛好在聊天室內靠這更新 (聊天室進背景再打開時)
//       GlobalData.saveMsgNotifier.notifier();
//     });

//     /// 聊天室修改紀錄
//     await _getChatroomUpdateRecordResponse(1, 10000, time, DateFormatUtil().getDateTimeStringNow())
//         .then((recordList) async {
//       _updateDBDataByAction(recordList);
//     });

//     // 存現在時間進SP
//     FmSharedPreferences.setChatroomListTime(DateFormatUtil().getDateTimeStringNow());
//     GlobalData.printLog('存完時間');

//     // 清暫存的roomId
//     GlobalData.roomId = '';
//   }

//   Future<List<MessageDirectRequestMessageResponseData>> _getChatroomListResponse(int page, int size,
//       {ResponseErrorFunction? onConnectFail}) async {
//     return await MessageApi(onConnectFail: onConnectFail).getRequestMessageResponse(page: page, size: size);
//   }

//   Future<void> _compareTimeToUpdateHistory(MessageDirectRequestMessageResponseData data, bool bGroup) async {
//     late String startTime, endTime;
//     Future<String> lastRecordTime = FmSharedPreferences.getChatRecordTime(data.roomId + GlobalData.userMemberId);

//     await lastRecordTime.then((value) {
//       if (bGroup) {
//         // 群組
//         int iGroupJoinTime = DateFormatUtil().timeStringToMilliseconds(data.groupJoinTime);
//         int iRecordTime = DateFormatUtil().timeStringToMilliseconds(value);
//         endTime = ; // 現在時間
//         bool isLate = iGroupJoinTime > iRecordTime; // 檢查加入時間 以防抓到加入前的紀錄
//         if (isLate) {
//           startTime = data.groupJoinTime;
//         } else {
//           startTime = value;
//         }
//         Future<List<MessageRecordResponseData>> list =
//             _getMessageRecordResponse(1, 50000, data.roomId, startTime, endTime);
//         list.then((value) async {
//           await _addHistoryToDbAtInit(value, data);
//           GlobalData.saveMsgNotifier.notifier(); // 通知存訊息記錄Notifier, 這樣點推播進來的才能在存完時刷新聊天室
//         });
//       } else if (data.lastChatRecord.createTime.isNotEmpty) {
//         // 單聊
//         int iTime = DateFormatUtil().timeStringToMilliseconds(data.lastChatRecord.createTime); // 最新訊息的時間
//         int iRecordTime = DateFormatUtil().timeStringToMilliseconds(value) - 20000; // -20000 以免發生誤差漏訊息
//         bool isNew = iTime > iRecordTime;
//         if (isNew) {
//           // 如果true, 代表有訊息尚未存進本地, 打聊天記錄API並存進DB
//           endTime = DateFormatUtil().getDateTimeStringNow(); // 現在時間
//           startTime = DateFormatUtil().subtractHourForMessage(value); // 上次紀錄時間減去一小時 防漏訊息
//           Future<List<MessageRecordResponseData>> list =
//               _getMessageRecordResponse(1, 50000, data.roomId, startTime, endTime);
//           list.then((value) async {
//             await _addHistoryToDbAtInit(value, data);
//             GlobalData.saveMsgNotifier.notifier(); // 通知存訊息記錄Notifier, 這樣點推播進來的才能在存完時刷新聊天室
//           });
//         }
//       }
//     });
//   }
// }
