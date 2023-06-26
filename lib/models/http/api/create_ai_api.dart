import 'package:base_project/models/http/http_manager.dart';

import '../data/feature_detail_data.dart';

/// ai 創建相關
class CreateAiAPI extends HttpManager {
  /// 查詢身體特徵列表
  Future<List<String>> queryBodyFeature() async {
    var response = await get("/createAvatar/bodyFeature");
    List<String> list = [];
    for (Map<String, dynamic> json in response.data) {
      if (json["status"] == "ENABLE") {
        list.add(json["feature"]);
      }
    }
    return list;
  }

  /// 查詢特徵詳細列表
  Future<List<FeatureDetailData>> queryFeatureDetail(String feature) async {
    var response = await get("/createAvatar/bodyFeatureDetail",
        queryParameters: {"feature": feature});
    List<FeatureDetailData> list = [];
    for (Map<String, dynamic> json in response.data) {
      var data = FeatureDetailData.fromJson(json);
      if (data.enable) {
        list.add(data);
      }
    }
    return list;
  }
}
