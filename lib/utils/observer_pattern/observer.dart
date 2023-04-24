import '../../constant/theme/global_data.dart';
import 'notification_data.dart';
///MARK: 觀察者

///MARK:參考網頁
/// https://flutter.cn/community/tutorials/observer-pattern-in-flutter-n-dart
class Observer {
  String name;

  Observer(this.name);

  void notify(NotificationData notification) {
    GlobalData.printLog("[${notification.createdTime}] Hey $name, ${notification.key}!");
  }
}