
import '../../../constant/enum/app_param_enum.dart';
import '../notification_data.dart';
import '../observer.dart';
import '../subject_key.dart';

class UserCommentObserver extends Observer {
  UserCommentObserver(super.name,
      {required this.changeMainPage});
  Function(AppNavigationBarType type) changeMainPage;

  @override
  void notify(NotificationData notification) {
    switch (notification.key) {
      case SubjectKey.keyMainScreen:
        {
          /// value 無用處
          changeMainPage(notification.data);
        }
        break;
    }
  }
}
