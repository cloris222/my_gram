//MARK: 檢查字串回傳的結果
import 'package:easy_localization/easy_localization.dart';
import '../../constant/theme/app_colors.dart';

class ValidateResultData {
  final bool result;
  final String message;
  final AppColors textColor;

  ValidateResultData(
      {this.result = true,
      this.message = '',
      this.textColor = AppColors.textError});

  String getMessage() {
    if (message.isEmpty) {
      return tr('rule_void');
    }
    return message;
  }
}
