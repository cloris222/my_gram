import 'package:base_project/models/http/api/create_ai_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 特徵值清單
final createTagProvider =
    StateNotifierProvider<CreateTagNotifier, List<String>>((ref) {
  return CreateTagNotifier();
});

class CreateTagNotifier extends StateNotifier<List<String>> {
  CreateTagNotifier() : super([]);

  Future<void> init() async {
    state = [...await CreateAiAPI().queryBodyFeature()];
  }
}
