import 'dart:math';

import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/view_models/create/create_tag_detail_provider.dart';
import 'package:base_project/view_models/create/create_tag_provider.dart';
import 'package:base_project/view_models/gobal_provider/global_tag_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../views/create/create_loading_page.dart';

/// 對應特徵值 已選擇的選項
final createChooseProvider = StateProvider.family.autoDispose<int, String>((ref, tag) {
  return -1;
});

class CreateMainViewModel extends BaseViewModel {
  CreateMainViewModel(this.ref);

  final WidgetRef ref;
  final String randomDialog = "randomDialog";
  int selectedIndex = 0;

  List<String> get tags => ref.read(createTagProvider);

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
        feature.add(list[index].tag);
      }
    }
    pushPage(context, CreateLoadingPage(features: feature));
  }

  void onPressInfo(BuildContext context) {}

  void onPressSpotlight(BuildContext context) {}

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
