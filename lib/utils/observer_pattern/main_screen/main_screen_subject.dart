

import '../../../constant/enum/app_param_enum.dart';
import '../notification_data.dart';
import '../subject.dart';
import '../subject_key.dart';

class MainScreenSubject extends Subject {
  void changeMainScreenPage(AppNavigationBarType type) {
    notifyObservers(
        NotificationData(key: SubjectKey.keyMainScreen, data: type));
  }

}
