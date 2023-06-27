import 'dart:math';

import 'package:base_project/models/http/data/dynamic_info_data.dart';
import 'package:base_project/models/http/data/store_info_data.dart';
import 'package:base_project/utils/pitch_data_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/http/data/chat_room_data.dart';
import '../../models/http/http_setting.dart';
import '../../models/http/data/country_phone_data.dart';
import '../../models/http/data/pair_image_data.dart';
import '../../models/http/data/post_comment_data.dart';
import '../../utils/observer_pattern/main_screen/main_screen_subject.dart';
import '../../views/message/notifier/chat_msg_notifier.dart';
import '../../views/message/notifier/userToken_notifier.dart';
import '../enum/app_param_enum.dart';

class GlobalData {
  GlobalData._();

  static String urlPrefix = '';

  static GlobalKey<NavigatorState> globalKey = GlobalKey();
  static bool firstLaunch = true;
  static List<CountryPhoneData> country = [];
  static AppNavigationBarType mainBottomType = AppNavigationBarType.typePair;

  /// 樣式
  static bool isDark = false;
  /// 固定ai id
  static String friendAvatarId = "1";

  /// USER
  // static String userToken = '';
  // static String userMemberId = '';
  // static int selfAvatar = 0;
  // static String roomId = "1";


  /// andrew
  static String userToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoibWVtYmVyIiwidXNlcklkIjoiTTAwSTYzOE9NSjkifQ.rBPeMwYepOsnNPMHEgqM7uw-Wrua7tFINO1e-0DU8jE';
  static String userMemberId = 'M00I638OMJ9';
  static int selfAvatar = 4;
  static String roomId = "3";

  /// salt
  // static String userToken="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoibWVtYmVyIiwidXNlcklkIjoiTTAwMDJYR1BEWkMifQ.b0U96pRGVnr9a6A99PARjSjY7dmo8h0BWdgSLnp5G34";
  // static String userMemberId="M0002XGPDZC";

  /// salt001
  // static String userToken="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoibWVtYmVyIiwidXNlcklkIjoiTTAwOVM1OEtORzYifQ.ewJ__UChoq2BQVxvf00L9tylvzKi4F_R-SpHKiJHu2w";
  // static String userMemberId="M009S58KNG6";
  // static int selfAvatar = 5;
  // static String roomId = "4";

  // Cloris
  // static String userToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoibWVtYmVyIiwidXNlcklkIjoiTTAwMDJYR1BEWkMifQ.ryzGxav0KI8OaVSZm44k9fmskE6-LhCu-0dPLxHvEv8';
  // static String userMemberId = 'M000C6314L4';



  /// RSA Public Key
  static String publicKey = '';
  static String apiSecretKey = '';
  static String userId = '';
  // static UserInfoData userInfo =
  //     UserInfoData(userId: 'loading...', avatar: '', mark: '');

  ///  主頁頁面切換的監聽
  static MainScreenSubject mainScreenSubject = MainScreenSubject();

  static printLog(String? logMessage) {
    if (HttpSetting.debugMode) {
      debugPrint(logMessage);
    }
  }

  /// notifier
  // static ChatroomNotifier chatroomNotifier = ChatroomNotifier();
  static ChatMsgNotifier chatMsgNotifier = ChatMsgNotifier();
  static UserTokenNotifier userTokenNotifier = UserTokenNotifier();

  /// dynamic 記住滑動位置
  static double dynamicOffset = 0;

  /// 測試資料
  static final List<String> photos = [
    "https://images.unsplash.com/photo-1586164383881-d01525b539d6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    "https://images.unsplash.com/photo-1594367031514-3aee0295ec98?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80",
    "https://images.unsplash.com/photo-1618759287629-ca56b5916066?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    "https://images.unsplash.com/photo-1586164383881-d01525b539d6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    "https://images.unsplash.com/photo-1594367031514-3aee0295ec98?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80",
    "https://images.unsplash.com/photo-1618759287629-ca56b5916066?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
  ];
  static final List<String> photos2 = [
    "https://images.unsplash.com/photo-1536589961747-e239b2abbec2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    "https://images.unsplash.com/photo-1577980906127-4ea7faa2c6f0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80",
    "https://images.unsplash.com/photo-1623411963493-e958d623cee0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    "https://images.unsplash.com/photo-1536589961747-e239b2abbec2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    "https://images.unsplash.com/photo-1577980906127-4ea7faa2c6f0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80",
    "https://images.unsplash.com/photo-1623411963493-e958d623cee0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
  ];
  static final List<String> photos3 = [
    "https://s3-alpha-sig.figma.com/img/1a29/b3b6/b67850394035bb55bf82660f80a5f2b9?Expires=1687737600&Signature=DNEup7q41iDgxBU3ZoCBpu01SfmkiTK3QobV4MMpSvfykoSlbj6ox4q8yxPpHqMtwRIFgmSRRpjJvc2Q3ptl9RGmrrFotxwBfSDvDKtQm0ZOPKh-Be5fuhsI-7utSMxbjzzi~G7WKBQH8V6pdML841QWVTlmX5jeE8QOu~KN03qE4VLxdJpYd-s~A9xE73AGa73qCqjME1Ml9Z46HLcJkJtI-~hql4kJrwLp-VWjR61ljmvAg7ozVPA4M7NcIkOxejDx8q8lCDLHvGbVL8VVVzPbu-m7kaoiDm-E98xQ80507hTsN87vmvmxwrnVmo5DqFiKf5pQBhsnPaILwvm-HQ__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4",
    "https://s3-alpha-sig.figma.com/img/977a/fece/b219f612f87a021f5edce35f73ff4507?Expires=1687737600&Signature=njj4ZGrsIYVkU4W06tb3PRmou~H4fcZFU1AuKnE9ebANL9W~uxJw2pIvzJf8hynRMAOitgT9rMyZDpnp16ehmfiG8ztLPY1voWIHLdwI4bjpDAvc2Po4-Rdczukp2MuMjfrUfA-4g5yxBW0sUBnA7x4zAPbQl02InbLJBmH7eHFje7J7-oN6RU4yLM5PCguGe7NU-7XENQapIyL~w7yID8wBhT-MC0yhM2nkFAy2yAPwgmBkQXd2vajLwlMHPiRyCNd1~JE8b-lV0t9jKlNkAdrsa8RItAmNJDFEpgKROR7OOG7lTW2nDCMJeSQrPm4K2CGR9X8tesqVg1Ri5soJ0w__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4",
    "https://s3-alpha-sig.figma.com/img/ce78/2ace/4f627fa9c94e505e9a40df1f54215e61?Expires=1687737600&Signature=LfOwx2mo6HyrrTCZ2~iEyfpznliq16eEpU0qdQAldBMcxd1VYxW38nZoEwBvr3-Y3lSWMmxL34NoTX4z20Tj8M~DFGgIhTXhEovO58jvLtnAq3dT5xslf4pE7UILh6H5CMLvYZ75As7ennCTKg6FJ4KKk7BpeGr-CfcM3FzG6OXgIIsqHzkUVIFbA~sLHtYx2kyRMGI7YXtMm4E9v0mSEblFE4W8liuZw6NkDJAKnFsoOs~GeLFMcuz~Ynf12i7YPgeSsx7ZPOzAMokFGOVh9uLVr1u~I80bawLkxhc0swEi5ZrhBR3QYFKL9tY4YRdpPPuktuXMPg6cgViqEENR4A__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4",
    "https://s3-alpha-sig.figma.com/img/8d4e/5d44/d79cf6c291da137138b041341587df9f?Expires=1687737600&Signature=HwTUlB7FIJYvk6Rl1e7cDVAOFgucAp-k3McnGmJS7vcEAZTtlpOL2ICsO2I7SePLMHS~FclyUEs8tFpJ4Pc8HbUVrYOeagxlw0JVryJL8WuX4EH3G5FjZ3Rpkp4NkVgDyZ8QeKL33~SUUFSB83OYLJ7zpDVuqTGACZNbsVo7D0qYJPNcSSoRqGUaqfIeM60bVrJi3aktgI-HJ~22qeA2NLnBPbMQhvwEYQnjwlseGIQ7Ic6vQrCdMybUHib~9wja-y5ZD7C4VGSn~iRkfBc2CdmBiAfJF-ds4cvpWCmVz5zgFYvZ8pNJ2wPT3p0OyoLbTuBVnwiUvkB4q788zOSweA__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4",
    "https://s3-alpha-sig.figma.com/img/fb03/175c/468672bb0a284c6967e1ef1c9f72b293?Expires=1687737600&Signature=Bnc3cWCN~wuar3hti9iA-PS~uOdzjWvZX59mw47XyEC5Z8aBfzzBTc3ST7DOP29B1RwOJoFFKOk1TIlv7wqGUKP9KGN5Kjg5P-yLrXZjp72Rpb1-rw9yzQoXBcukRfIBkomvzRbJGU7CC3tN0durQ39ljMPxopVT-rtAzHdk4vhHXLvb0NKRV8cDs7GLDw1AShaTcdrJv4GP4nX-qU8Fp0CbVX-IkJM-dbcyXswUWjqnyZOhH6d4-719suFUK~oTon3wqjyBqMAxF0Oob-y7n2E2XLVFN8xbMWidleJ3aW6wt2BJukpCQiusN1NWrZ3sussHOBEbX1iPmWIkISAnZQ__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4",
  ];

  static List<PostCommentData> generateCommentData(int page, int size, {required bool isMain, String replyId = ""}) {
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
          comments: 30 * index,
          images: photos,
          likes: 100 * index,
          time: '2023-04-01');
    });
  }

  static List<StoreInfoData> generateStoreData(int length) {
    return List<StoreInfoData>.generate(length, (index) {
      int random = Random().nextInt(3);
      return StoreInfoData(avatar: photos[random], name: 'store$random', list: generateDynamicData(10));
    });
  }

  static List<ChatRoomData> generateChatRoomData(int length) {
    String text = 'text';
    int random = Random().nextInt(3);
    return List<ChatRoomData>.generate(length, (index) {
      return ChatRoomData(
          nickName: 'user$random',
          avatar: photos[random],
          content: text * random + text,
          time: index % 2 == 0 ? '2023-0$random-05 12:00' : '2023-05-10 0${random + 5}:00',
          isRead: index % 2 == 0,
          beRead: index % 3 == 0,
          imageList: []);
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

  static List<PairImageData> generatePairImageData(int length) {
   
   return PitchDataUtil().buildPairData();
  }

  static List<DynamicInfoData> generateIsRebeccaData(int length) {
  
    return PitchDataUtil().buildSelf(length);
  }

  static List<DynamicInfoData> generateNotRebeccaData(int length) {
  
    return PitchDataUtil().buildOther();
  }
}
