import 'package:base_project/constant/theme/global_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../models/data/chat_room_data.dart';
import '../../models/data/register_preference_choose_data.dart';


final chatRoomProvider = StateNotifierProvider.autoDispose<
    chatRoomProviderNotifier, List<AssetEntity>>((ref) {
  return chatRoomProviderNotifier();
});

class chatRoomProviderNotifier extends StateNotifier<List<AssetEntity>> {
  chatRoomProviderNotifier() : super([]);

  void updateImageSelection(AssetEntity value) {
    if(state.length>=4)return;
    final data = state;
    data.add(value);
    state = [...data]; // 更新state
  }

  void delImageSelection(AssetEntity value){
    final data = state;
    final index = data.indexWhere((el) => value.id == el.id);
    data.removeAt(index);
    state = [...data];
  }

  void clearImageList(){
    state = [];
  }
}
