import 'package:base_project/models/http/api/create_ai_api.dart';
import 'package:base_project/view_models/call_back_function.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/app_shared_preferences.dart';
import '../../models/http/data/feature_detail_data.dart';
import '../base_pref_provider.dart';

/// 特徵值的詳細資料
final createTagDetailProvider = StateNotifierProvider.family<
    CreateTagDetailNotifier, List<FeatureDetailData>, String>((ref, tag) {
  return CreateTagDetailNotifier(tag: tag);
});

class CreateTagDetailNotifier extends StateNotifier<List<FeatureDetailData>>
    with BasePrefProvider {
  CreateTagDetailNotifier({required this.tag}) : super([]);
  final String tag;

  @override
  Future<void> initValue() async {
    state = [];
  }

  @override
  bool needEncryption() {
    return false;
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async {
    state = [...await CreateAiAPI().queryFeatureDetail(tag)];
  }

  @override
  Future<void> readSharedPreferencesValue() async {
    var json = await AppSharedPreferences.getJson(getSharedPreferencesKey(),
        needEncryption: needEncryption());
    if (json != null) {
      state = [
        ...List<FeatureDetailData>.from(
            json.map((x) => FeatureDetailData.fromJson(x)))
      ];
    }
  }

  @override
  String setKey() {
    return "createTagDetail_$tag";
  }

  @override
  Future<void> setSharedPreferencesValue() async {
    await AppSharedPreferences.setJson(getSharedPreferencesKey(),
        List<dynamic>.from(state.map((x) => x.toJson())),
        needEncryption: needEncryption());
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }
}
