import 'package:base_project/models/http/data/api_response.dart';
import 'package:base_project/models/http/data/user_info_data.dart';
import 'package:base_project/models/http/http_manager.dart';

import '../data/register_data.dart';
import '../http_setting.dart';

class UserAPI extends HttpManager {
  UserAPI({super.onConnectFail, super.baseUrl = HttpSetting.appUrl});

  /// 登入email
  Future<ApiResponse> loginWithEmail(
      {required String email, required String password}) async {
    return await post("/user/login", data: {
      "type": "NORMAL",
      "email": email,
      "password": await encodeContext(password),
    });
  }

  /// 更新使用者資料用
  Future<UserInfoData> uploadPersonalInfo() async {
    var response = await get("/user/info");
    return UserInfoData.fromJson(response.data);
  }

  /// 登入email
  Future<ApiResponse> registerWithEmail({
    required RegisterData data,
  }) async {
    data = data.copyWith(password: await encodeContext(data.password));

    return await post("/user/register", data: data.toJson());
  }
}
