import 'package:base_project/models/http/api/user_api.dart';
import 'package:base_project/models/http/data/api_response.dart';
import 'package:base_project/models/http/data/user_info_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/global_data.dart';
import '../../models/app_shared_preferences.dart';
import '../../models/http/data/register_data.dart';

final userInfoProvider =
    StateNotifierProvider<UserInfoNotifier, UserInfoData?>((ref) {
  return UserInfoNotifier();
});

class UserInfoNotifier extends StateNotifier<UserInfoData?> {
  UserInfoNotifier() : super(null);

  Future<void> loginWithMail(
      {required String email, required String password}) async {
    var response =
        await UserAPI().loginWithEmail(email: email, password: password);

    _saveUserData(response);
  }

  Future<void> updateUserInfo() async {
    state = await UserAPI().uploadPersonalInfo();
  }

  Future<void> registerWithMail({required RegisterData data}) async {
    var response = await UserAPI().registerWithEmail(data: data);
    _saveUserData(response);
  }

  void _saveUserData(ApiResponse response) async {
    GlobalData.userToken = response.data['token'];
    GlobalData.userMemberId = response.data['userId'];
    await AppSharedPreferences.setToken(GlobalData.userToken);
    await AppSharedPreferences.setMemberID(GlobalData.userMemberId);
    await AppSharedPreferences.setLogIn(true);

    state = UserInfoData.fromJson(response.data);
  }
}
