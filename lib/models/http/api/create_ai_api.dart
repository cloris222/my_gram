import 'package:base_project/models/http/data/popular_create_data.dart';
import 'package:base_project/models/http/http_manager.dart';

import '../data/create_ai_info.dart';
import '../data/feature_detail_data.dart';

/// ai 創建相關
class CreateAiAPI extends HttpManager {
  CreateAiAPI({super.onConnectFail});

  /// 查詢近期、熱門
  // Future<List<PopularCreateData>> queryPopular() async {
  //   var response = await get("/createAvatar/getPromptByType");
  //   return 
  // }

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

  /// 創建ai
  Future<CreateAiInfo> createAi(List<String> features) async {
    // String feature = "";
    // for (var element in features) {
    //   feature+="$element,";
    // }
    // if(feature.isNotEmpty){
    //   feature=feature.substring(0,feature.length-1);
    // }
    var response = await post("/createAvatar/createImg",
        data: {"feature": features, "sdRequestParamSettingId": 1});
    return CreateAiInfo.fromJson(response.data);
  }
}
