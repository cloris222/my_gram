
import '../../../constant/enum/app_param_enum.dart';
import '../notification_data.dart';
import '../observer.dart';
import '../subject_key.dart';

class MainScreenObserver extends Observer {
  MainScreenObserver(super.name,
      {required this.changeMainPage});
  Function(AppNavigationBarType type,bool isRebecca) changeMainPage;

  @override
  void notify(NotificationData notification) {
    switch (notification.key) {
      case SubjectKey.keyMainScreen:
        {
          changeMainPage(notification.data["type"],notification.data["isRebecca"]);
        }
        break;
    }
  }
}
