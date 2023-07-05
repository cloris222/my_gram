import 'package:base_project/models/http/api/create_ai_api.dart';
import 'package:base_project/view_models/call_back_function.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/app_shared_preferences.dart';
import '../base_pref_provider.dart';

/// 特徵值清單
final createTagProvider =
    StateNotifierProvider<CreateTagNotifier, List<String>>((ref) {
  return CreateTagNotifier();
});

class CreateTagNotifier extends StateNotifier<List<String>> with BasePrefProvider{
  CreateTagNotifier() : super([]);

  @override
  Future<void> initValue() async{
    state = [];
  }

  @override
  bool needEncryption() {
    return false;
  }

  @override
  Future<void> readAPIValue({ResponseErrorFunction? onConnectFail}) async{
    state = [...await CreateAiAPI().queryBodyFeature()];
  }

  @override
  Future<void> readSharedPreferencesValue() async{
   state =  [...await AppSharedPreferences.getStringList(getSharedPreferencesKey(), needEncryption: needEncryption())];

  }

  @override
  String setKey() {
   return "createTag";
  }

  @override
  Future<void> setSharedPreferencesValue() async{
    AppSharedPreferences.setStringList(getSharedPreferencesKey(), state, needEncryption: needEncryption());
  }

  @override
  bool setUserTemporaryValue() {
   return false;
  }
}
