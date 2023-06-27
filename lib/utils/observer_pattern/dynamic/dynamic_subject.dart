

import '../../../constant/enum/app_param_enum.dart';
import '../notification_data.dart';
import '../subject.dart';
import '../subject_key.dart';

class DynamicSubject extends Subject {
  void scrollTop() {
    notifyObservers(
        NotificationData(key: SubjectKey.keyDynamicTop));
  }

}
