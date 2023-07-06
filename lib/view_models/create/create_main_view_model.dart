import 'dart:math';

import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/models/http/api/create_ai_api.dart';
import 'package:base_project/models/http/data/popular_create_data.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/view_models/create/create_tag_detail_provider.dart';
import 'package:base_project/view_models/create/create_tag_provider.dart';
import 'package:base_project/view_models/gobal_provider/global_tag_controller_provider.dart';
import 'package:base_project/views/create/other_create_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../views/create/create_loading_page.dart';

/// 對應特徵值 已選擇的選項
final createChooseProvider = StateProvider.family.autoDispose<int, String>((ref, tag) {
  return -1;
});

/// 熱門創建
final hotCreateDataProvider = StateNotifierProvider<HotCreateDataNotifier, List<PopularCreateData>>(
  (ref) => HotCreateDataNotifier(),
);

final hotSelectIdProvider = StateProvider<String>((ref) => "");

class HotCreateDataNotifier extends StateNotifier<List<PopularCreateData>> {
  HotCreateDataNotifier() : super([]);
  void addPopularCreateData(PopularCreateData data) {
    state = [...state, data];
  }

  void cleanPopularCreateData() {
    state = [];
  }
}

/// 近期創建
final popularCreateDataProvider = StateNotifierProvider<PopularCreateDataNotifier, List<PopularCreateData>>(
  (ref) => PopularCreateDataNotifier(),
);

final popularSelectIdProvider = StateProvider<String>((ref) => "");

class PopularCreateDataNotifier extends StateNotifier<List<PopularCreateData>> {
  PopularCreateDataNotifier() : super([]);
  void addPopularCreateData(PopularCreateData data) {
    state = [...state, data];
  }

  void cleanPopularCreateData() {
    state = [];
  }
}

class CreateMainViewModel extends BaseViewModel {
  CreateMainViewModel(this.ref);

  /// otherCreate
  List tabs = ["recent".tr(), "popular".tr()];
  List<PopularCreateData> recentData = [];
  List<PopularCreateData> hotData = [];
  List<String> selectData = [];

  ///

  final WidgetRef ref;
  final String randomDialog = "randomDialog";
  int selectedIndex = 0;

  List<String> get tags => ref.read(createTagProvider);

  /// otherCreateFunction
  Future<void> getPrompt() async {
    String theType = "RECENT";
    await CreateAiAPI().popularFeature(theType).then((value) {
      ref.read(popularCreateDataProvider.notifier).cleanPopularCreateData();
      final List<PopularCreateData> pageList = value;
      for (var item in pageList) {
        ref.read(popularCreateDataProvider.notifier).addPopularCreateData(item);
      }
    });
    theType = "HOT";
    await CreateAiAPI().popularFeature(theType).then((value) {
      ref.read(hotCreateDataProvider.notifier).cleanPopularCreateData();
      final List<PopularCreateData> pageList = value;
      for (var item in pageList) {
        ref.read(hotCreateDataProvider.notifier).addPopularCreateData(item);
      }
    });
  }

  void applyAi(BuildContext context) {
    bool isPopular = true;
    onPressCreate(context, isPopular);
  }

  ///

  void init() {
    Future.delayed(Duration.zero).then((value) async {
      await ref.read(createTagProvider.notifier).update();
      for (var element in tags) {
        ref.read(createTagDetailProvider(element).notifier).update();
      }
    });
  }

  void onPressCreate(BuildContext context, bool popular) {
    List<String> feature = [];
    if (!popular) {
      print("is");
      for (var tag in tags) {
        var list = ref.read(createTagDetailProvider(tag));
        int index = ref.read(createChooseProvider(tag));
        if (index != -1) {
          feature.add(list[index].prompt);
        }
      }
    } else {
      print("else");
      feature = selectData;
      Navigator.of(context).pop();
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
