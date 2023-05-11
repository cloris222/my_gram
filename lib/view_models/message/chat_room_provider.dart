import 'package:base_project/constant/theme/global_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../models/data/chat_room_data.dart';
import '../../models/data/register_preference_choose_data.dart';


final chatRoomProvider = StateNotifierProvider.autoDispose<
    chatRoomProviderNotifier, ChatRoomData>((ref) {
  return chatRoomProviderNotifier();
});

class chatRoomProviderNotifier extends StateNotifier<ChatRoomData> {
  chatRoomProviderNotifier() : super(ChatRoomData(imageList: []));

  void updateImageSelection(AssetEntity value) {
    if(state.imageList.length>=4)return;
    final data = state;
    data.imageList.add(value);
    state = data; // 更新state
  }

  void clearImageList(){
    final data = state;
    data.imageList = [];
    state = data;
  }
}
