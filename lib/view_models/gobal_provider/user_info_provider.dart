import 'package:base_project/models/http/api/message_api.dart';
import 'package:base_project/models/http/api/user_api.dart';
import 'package:base_project/models/http/data/api_response.dart';
import 'package:base_project/models/http/data/user_info_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/global_data.dart';
import '../../models/app_shared_preferences.dart';
import '../../models/http/data/register_data.dart';
import '../create/create_tag_detail_provider.dart';
import '../create/create_tag_provider.dart';

final userInfoProvider =
    StateNotifierProvider<UserInfoNotifier, UserInfoData?>((ref) {
  return UserInfoNotifier();
});

class UserInfoNotifier extends StateNotifier<UserInfoData?> {
  UserInfoNotifier() : super(null);

  Future<void> registerWithMail(WidgetRef ref,
      {required RegisterData data}) async {
    var response = await UserAPI(addToken: false).registerWithEmail(data: data);
    _saveUserData(ref, response);
  }

  Future<void> loginWithMail(WidgetRef ref,
      {required String email, required String password}) async {
    var response = await UserAPI(addToken: false)
        .loginWithEmail(email: email, password: password);

    _saveUserData(ref, response);
  }

  Future<void> updateUserInfo(WidgetRef ref) async {
    state = await UserAPI().uploadPersonalInfo();
    await _chatRoom();
    _initCreateProvider(ref);
    _initUrlPrefix();
  }

  void _saveUserData(WidgetRef ref, ApiResponse response) async {
    GlobalData.userToken = response.data['token'];
    GlobalData.userMemberId = response.data['userId'];
    await AppSharedPreferences.setToken(GlobalData.userToken);
    await AppSharedPreferences.setMemberID(GlobalData.userMemberId);
    await AppSharedPreferences.setLogIn(true);

    /// 更新連線
    GlobalData.userTokenNotifier.setUserToken = GlobalData.userToken;

    await updateUserInfo(ref);
  }

  /// 預載創建資料
  void _initCreateProvider(WidgetRef ref) async {
    await ref.read(createTagProvider.notifier).init();
    for (var element in ref.read(createTagProvider)) {
      ref.read(createTagDetailProvider(element).notifier).init();
    }
  }

  /// 更新前綴
  void _initUrlPrefix() {
    MessageApi().getFilePrefix().then((value) {
      String url = value.data;
      if (url.contains("http")) {
        GlobalData.urlPrefix = url;
      } else {
        GlobalData.urlPrefix = "https://$url";
      }
      GlobalData.printLog("urlPrefix:${GlobalData.urlPrefix}");
    });
  }

  /// 更新使用者房號等資料
  Future<void> _chatRoom() async {
    GlobalData.selfAvatar = state?.avatars
            .where((element) => (element.type == "MEMBER"))
            .first
            .avatarIds
            .first ??
        0;
    GlobalData.roomId =
        await MessageApi().createMessageRoom(GlobalData.friendAvatarId) ?? "0";
    GlobalData.printLog("self:${GlobalData.selfAvatar}");
    GlobalData.printLog("room:${GlobalData.roomId}");
  }
}
