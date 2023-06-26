

import '../../../constant/enum/app_param_enum.dart';
import '../notification_data.dart';
import '../subject.dart';
import '../subject_key.dart';

class MainScreenSubject extends Subject {
  void changeMainScreenPage(AppNavigationBarType type,{bool isRebecca=false}) {
    notifyObservers(
        NotificationData(key: SubjectKey.keyMainScreen, data: {"type":type,"isRebecca":isRebecca}));
  }

}
