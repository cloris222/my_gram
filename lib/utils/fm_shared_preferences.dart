import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/theme/global_data.dart';

class FmSharedPreferences{

  static Future<SharedPreferences> _getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static Future<String> _getString(String key,
      {String defaultValue = ''}) async {
    SharedPreferences pref = await _getPreferences();
    if (pref.containsKey(key)) {
      return pref.getString(key)!;
    } else {
      
      return defaultValue;
    }
  }

  static Future<String> getChatroomListTime() async {
    return await _getString('ChatroomListTime${GlobalData.userMemberId}',
        defaultValue: '1995-12-24 00:00:00.000');
  }

    static Future<String> getChatRecordTime(String roomIdWithMyMemberId) async {
    return await _getString(roomIdWithMyMemberId,
        defaultValue: '1995-12-24 00:00:00.000');
  }

}