import '../http_manager.dart';
import '../http_setting.dart';

class DemoAPI extends HttpManager {
  DemoAPI({super.onConnectFail, super.baseUrl = HttpSetting.appUrl});


}
