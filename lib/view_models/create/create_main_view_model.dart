import 'dart:math';

import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/models/http/api/create_ai_api.dart';
import 'package:base_project/models/http/data/popular_create_data.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/view_models/create/create_tag_detail_provider.dart';
import 'package:base_project/view_models/create/create_tag_provider.dart';
import 'package:base_project/view_models/gobal_provider/global_tag_controller_provider.dart';
import 'package:base_project/views/create/other_create_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../views/create/create_loading_page.dart';

/// 對應特徵值 已選擇的選項
final createChooseProvider = StateProvider.family.autoDispose<int, String>((ref, tag) {
  return -1;
});

final popularCreateDataProvider = StateNotifierProvider<PopularCreateDataNotifier, List<PopularCreateData>>(
  (ref) => PopularCreateDataNotifier(),
);

class PopularCreateDataNotifier extends StateNotifier<List<PopularCreateData>> {
  PopularCreateDataNotifier() : super([]);
  void addPopularCreateData(PopularCreateData data) {
    state = [...state, data];
  }
}

class CreateMainViewModel extends BaseViewModel {
  CreateMainViewModel(this.ref);

  /// otherCreate
  List<PopularCreateData> recentData = [];
  List<PopularCreateData> hotData = [];

  ///

  final WidgetRef ref;
  final String randomDialog = "randomDialog";
  int selectedIndex = 0;

  List<String> get tags => ref.read(createTagProvider);

  /// otherCreateFunction
  Future<void> getPrompt(Function() updateUi) async {
    String theType = "RECENT";
    await CreateAiAPI().popularFeature(theType).then((value) {
      print("return data: ${value}");
      final List<PopularCreateData> pageList = value;
      for (var item in pageList) {
        ref.read(popularCreateDataProvider.notifier).addPopularCreateData(item);
      }
      // recentData.clear();
      // recentData = value;
      // List<dynamic> valueList = value.data["pageList"];
      // valueList.map((e) {
      //   recentData.add(PopularCreateData(id: e["id"].toString(), imgUrl: e["imgUrl"]));
      // }).toList();
    });
    // recentDat
    // GlobalData.printLog("isRencent: ${recentData}");
    theType = "HOT";
    await CreateAiAPI().popularFeature(theType).then((value) {
      hotData.clear();
      hotData = value;
    });
    updateUi;
  }

  ///

  void init() {
    Future.delayed(Duration.zero).then((value) async {
      await ref.read(createTagProvider.notifier).init();
      for (var element in tags) {
        ref.read(createTagDetailProvider(element).notifier).init();
      }
    });
  }

  void onPressCreate(BuildContext context) {
    List<String> feature = [];
    for (var tag in tags) {
      var list = ref.read(createTagDetailProvider(tag));
      int index = ref.read(createChooseProvider(tag));
      if (index != -1) {
        feature.add(list[index].prompt);
      }
    }
    pushPage(context, CreateLoadingPage(features: feature));
  }

  void onPressInfo(BuildContext context) {}

  void onPressSpotlight(BuildContext context) {
    changePageFromRight(context, OtherCreatePage());
    // pushStackPage(context, OtherCreatePage());
  }

  void onPressFaceAR(BuildContext context) {}

  void onPressRandom(BuildContext context) {
    for (var tag in tags) {
      var list = ref.read(createTagDetailProvider(tag));
      int random = -1;
      if (list.isNotEmpty) {
        random = Random().nextInt(list.length);
      }
      ref.read(createChooseProvider(tag).notifier).update((state) => random);
    }
    ref.read(globalBoolProvider(randomDialog).notifier).update((state) => true);
    Future.delayed(const Duration(milliseconds: 1500))
        .then((value) => ref.read(globalBoolProvider(randomDialog).notifier).update((state) => false));
  }
}
