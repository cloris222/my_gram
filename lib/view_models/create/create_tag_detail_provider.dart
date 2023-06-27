import 'package:base_project/models/http/api/create_ai_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/http/data/feature_detail_data.dart';

/// 特徵值的詳細資料
final createTagDetailProvider = StateNotifierProvider.family<
    CreateTagDetailNotifier, List<FeatureDetailData>, String>((ref, tag) {
  return CreateTagDetailNotifier(tag: tag);
});

class CreateTagDetailNotifier extends StateNotifier<List<FeatureDetailData>> {
  CreateTagDetailNotifier({required this.tag}) : super([]);
  final String tag;

  Future<void> init() async {
    state = [...await CreateAiAPI().queryFeatureDetail(tag)];
  }
}
