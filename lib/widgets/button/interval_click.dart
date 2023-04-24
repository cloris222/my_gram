import 'dart:ui';

import '../../constant/theme/global_data.dart';
/// 防止重複點擊button
class IntervalClick {
  DateTime? _delay;
  void intervalClick(int needTime, VoidCallback onPressed) {
    if (_delay == null ||
        DateTime.now().difference(_delay!) > Duration(seconds: needTime)) {
      GlobalData.printLog("允許點擊");
      _delay = DateTime.now();
      onPressed();
    } else {
      GlobalData.printLog("重複點擊");
    }
  }
}
