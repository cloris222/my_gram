
import '../../../constant/enum/app_param_enum.dart';
import '../notification_data.dart';
import '../observer.dart';
import '../subject_key.dart';

class DynamicObserver extends Observer {
  DynamicObserver(super.name,
      {required this.scrollTop});
  Function() scrollTop;

  @override
  void notify(NotificationData notification) {
    switch (notification.key) {
      case SubjectKey.keyDynamicTop:
        {
          scrollTop();
        }
        break;
    }
  }
}
