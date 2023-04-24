import 'package:easy_localization/easy_localization.dart';

class NumberFormatUtil {
  String _setNumberFormat({required String format, dynamic value}) {
    return value != null ? NumberFormat(format).format(value) : '0';
  }

  ///MARK: 小數點兩位 無條件捨去,[needSeparator]是否需要千位號
  String removeTwoPointFormat(dynamic value, {bool needSeparator = true}) {
    return _setNumberFormat(
        format: needSeparator ? '#,##0.##' : '##0.##',
        value: double.parse(removePointFormat(value, 2)));
  }

  ///MARK: 小數點後[point]位 無條件捨去
  String removePointFormat(dynamic value, int point) {
    if (value == null) {
      return '0';
    }
    var num;
    if (value is double) {
      num = value;
    } else {
      if (value is String) {
        if (value.isEmpty) {
          value = '0.0';
        }
      }
      num = double.parse(value.toString());
    }
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) < point) {
      return (num.toStringAsFixed(point)
          .substring(0, num.toString().lastIndexOf(".") + point + 1)
          .toString());
    } else {
      return (num.toString()
          .substring(0, num.toString().lastIndexOf(".") + point + 1)
          .toString());
    }
  }

  ///取整數,[needSeparator]是否需要千位號
  String integerFormat(dynamic value, {bool hasSeparator = true}) {
    return _setNumberFormat(
        format: hasSeparator ? '#,##0' : '##0', value: value);
  }

  ///取整數(01,02...)
  String integerTwoFormat(dynamic value) {
    if (value is String) {
      value = num.parse(value);
    }
    return _setNumberFormat(format: '00', value: value);
  }

  ///MARK: 自動轉換數字為 K & M (小數點後去0)
  String numberCompatFormat(String value, {int decimalDigits = 2}) {
    if (value == '') {
      return '';
    }

    RegExp regex = RegExp(r'([.]*0+)(?!.*\d)'); // 小數點後 去除尾數0
    if (value.contains('.')) {
      value.replaceAll(regex, '');
    }

    String formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      locale: 'en_US',
      symbol: '',
    ).format(double.parse(value));

    if (formattedNumber.contains('.')) {
      String result = formattedNumber.replaceAll(regex, '');
      return result;
    }

    return formattedNumber;
  }
}
