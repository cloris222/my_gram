import '../../utils/number_format_util.dart';

extension IntExtension on int {
  int checkNegativeNumber() {
    if (this < 0) {
      return 0;
    }
    return this;
  }

  String numberCompatFormat() {
    return NumberFormatUtil().numberCompatFormat(toString(), decimalDigits: 0);
  }
}
