import 'dart:math';

import 'package:base_project/models/data/dynamic_info_data.dart';
import 'package:base_project/models/data/message_info_data.dart';
import 'package:base_project/models/data/store_info_data.dart';
import 'package:flutter/cupertino.dart';
import '../../models/data/chat_room_data.dart';
import '../../models/data/user_friends_data.dart';
import '../../models/http_setting.dart';
import '../../models/parameter/country_phone_data.dart';
import '../../models/parameter/pair_image_data.dart';
import '../../models/parameter/post_comment_data.dart';
import '../enum/app_param_enum.dart';

class GlobalData {
  GlobalData._();

  static String urlPrefix = '';

  static GlobalKey<NavigatorState> globalKey = GlobalKey();
  static bool firstLaunch = true;
  static List<CountryPhoneData> country = [];
  static AppNavigationBarType mainBottomType = AppNavigationBarType.typePair;

  /// USER
  static String userToken = '';
  static String userMemberId = '';

  /// RSA Public Key
  static String publicKey = '';
  static String apiSecretKey = '';
  static String userId = '';

  static printLog(String? logMessage) {
    if (HttpSetting.debugMode) {
      debugPrint(logMessage);
    }
  }

  /// 測試資料
  static final List<String> photos = [
    "https://images.unsplash.com/photo-1586164383881-d01525b539d6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    "https://images.unsplash.com/photo-1594367031514-3aee0295ec98?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80",
    "https://images.unsplash.com/photo-1618759287629-ca56b5916066?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
  ];
  static final List<String> photos2 = [
    "https://images.unsplash.com/photo-1536589961747-e239b2abbec2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    "https://images.unsplash.com/photo-1577980906127-4ea7faa2c6f0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80",
    "https://images.unsplash.com/photo-1623411963493-e958d623cee0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
  ];

  static List<PostCommentData> generateCommentData(int page, int size,
      {required bool isMain, String replyId = ""}) {
    return List<PostCommentData>.generate(size, (index) {
      int random = Random().nextInt(3);
      return PostCommentData(
        commentId: '${(page - 1) * 10 + index + 1}',
        replyId: replyId,
        avatarUrl: isMain ? photos[random] : photos2[random],
        userName: "${isMain ? "main" : "sub"}_$random",
        commentContext: isMain ? photos[random] : photos2[random],
        isLike: index % 2 != 0,
        likes: index * 500,
      );
    });
  }

  static List<DynamicInfoData> generateDynamicData(int length) {
    return List<DynamicInfoData>.generate(length, (index) {
      int random = Random().nextInt(3);
      return DynamicInfoData(
        avatar: photos2[random],
        name: 'user$index',
        context: 'text',
        comments: 30*index,
        images: photos,
        likes: 100*index,
        time: '2023-04-01'
      );
    });
  }

  static List<StoreInfoData> generateStoreData(int length) {
    return List<StoreInfoData>.generate(length, (index) {
      int random = Random().nextInt(3);
      return StoreInfoData(
        avatar: photos[random],
        name: 'store$random',
        list: generateDynamicData(10)
      );
    });
  }

  static List<ChatRoomData> generateChatRoomData(int length){
    String text = 'text';
    int random = Random().nextInt(3);
    return List<ChatRoomData>.generate(length, (index){
      return ChatRoomData(
          nickName: 'user$random',
          avatar:photos[random],
          content: text * random + text,
          time: index % 2==0?'2023-0$random-05 12:00':'2023-05-10 0${random+5}:00',
          isRead: index % 2 == 0,
          beRead:  index % 3 ==0, imageList: []
      );
    });
  }

  // static List<UserFriendsData> generateUserFriendsData(int length){
  //   return List<UserFriendsData>.generate(length, (index) {
  //     int random = Random().nextInt(3);
  //     return UserFriendsData(
  //       avatar: photos[random],
  //       name: 'store$random',
  //       isPin: index % 3 == 0,
  //       messageData: generateMessageInfoData(20),
  //       userId: index
  //     );
  //   });
  // }

  static List<PairImageData> generatePairImageData(int length){
    return List<PairImageData>.generate(length, (index) {
      int random = Random().nextInt(3);
      return PairImageData(
          images: photos,
        name: 'user$random',
        context: 'user$random',
      );
    });
  }
}
