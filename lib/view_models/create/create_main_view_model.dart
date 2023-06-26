import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/view_models/create/create_tag_detail_provider.dart';
import 'package:base_project/view_models/create/create_tag_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 對應特徵值 已選擇的選項
final createChooseProvider =
    StateProvider.family.autoDispose<int, String>((ref, tag) {
  return -1;
});

class CreateMainViewModel extends BaseViewModel {
  CreateMainViewModel(this.ref);

  final WidgetRef ref;

  List<String> get tags => ref.read(createTagProvider);

  void init() {
    Future.delayed(Duration.zero).then((value) async {
      await ref.read(createTagProvider.notifier).init();
      for (var element in tags) {
        ref.read(createTagDetailProvider(element).notifier).init();
      }
    });
  }

  void onPressCreate(BuildContext context) {}

  void onPressInfo(BuildContext context) {}

  void onPressSpotlight(BuildContext context) {}

  void onPressFaceAR(BuildContext context) {}

  void onPressRandom(BuildContext context) {}
}
