import 'package:easy_localization/easy_localization.dart';
import 'package:base_project/utils/number_format_util.dart';

import 'language_util.dart';

class DateFormatUtil {
  ///日期格式化,
  ///[strFormat] 日期格式,
  ///[time] 需格式化的時間,
  ///[needLocale] 時間格式是否顯示與語言相同，預設為顯示英文格式,
  ///
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS"); // For聊天記錄

  String buildDataFormat({required String strFormat, required DateTime time, bool needLocale = false}) {
    return DateFormat(strFormat, needLocale ? LanguageUtil.getTimeLocale() : "en").format(time);
  }

  DateTime _getNow() {
    return DateTime.now();
  }

  ///MARK: 2022/09/06 11:46 AM
  String getDateWith12HourFormat(DateTime time) {
    return buildDataFormat(strFormat: 'yyyy/MM/dd hh:mm a', time: time);
  }

  ///MARK: 2022-09-06 11:46 AM
  String getDateWith12HourFormat2(DateTime time) {
    return buildDataFormat(strFormat: 'yyyy-MM-dd hh:mm a', time: time);
  }

  ///MARK: 06 Sep 2022
  String getDateWithDayMouthYear(DateTime time) {
    return buildDataFormat(strFormat: 'dd LLL yyyy', time: time);
  }

  /// calculate time
  String calculateTime(DateTime commentTime) {
    var result = '';
    var starTime = commentTime;
    var endTime = DateTime.now();
    var timeLag = endTime.difference(starTime);

    var second = timeLag.inSeconds;
    var minutes = timeLag.inMinutes;
    var hour = timeLag.inHours;
    var day = timeLag.inDays;
    var week = endTime.difference(starTime).inDays % 7;

    if (week > 7) {
      return week.toString();
    } else if (day > 1 || day == 1) {
      return day.toString();
    } else if (hour < 24 && hour > 0) {
      return hour.toString();
    } else if (minutes > 0 && minutes < 60) {
      return minutes.toString();
    } else if (second >= 0 && second < 60) {
      return second.toString();
    } else {
      return result;
    }
  }

  /// String 轉 DateTime
  DateTime stringToDateTime(String value) {
    return dateFormat.parse(value);
  }

  /// DateTime 轉 String
  String dateTimeToString(DateTime dt) {
    return dateFormat.format(dt);
  }

  bool compareDateTime(String t1, String t2) {
    if (t1.isNotEmpty && t2.isNotEmpty) {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
      return dateFormat.parse(t1).isAfter(stringToDateTime(t2));
    }
    return false;
  }

  ///Increase one day & 8AM
  String increaseOneDay(DateTime time) {
    var newDate = DateTime(time.year, time.month, time.day + 1, 8, 0);
    return buildDataFormat(strFormat: 'yyyy-MM-dd hh:mm a', time: newDate);
  }

  ///InterestsCalculation
  String interestsCalculation(DateTime startTime, int duration) {
    var newDate01 = DateTime(startTime.year, startTime.month, startTime.day + 1);
    var newDate02 = DateTime(newDate01.year, newDate01.month, newDate01.day + duration);
    return buildDataFormat(strFormat: 'yyyy-MM-dd hh:mm a', time: newDate02);
  }

  ///redemptionDate
  String redemptionDate(DateTime startTime, int duration) {
    var newDate01 = DateTime(startTime.year, startTime.month, startTime.day + 1, 8, 0);
    var newDate02 = DateTime(newDate01.year, newDate01.month, newDate01.day + duration + 1, 8);
    return buildDataFormat(strFormat: 'yyyy-MM-dd hh:mm a', time: newDate02);
  }

  ///MARK: 18:46 24H
  String getNowTimeWith24HourFormat() {
    return buildDataFormat(strFormat: 'HH:mm', time: _getNow());
  }

  /// 現在時間 ex: 2022-10-18
  String getNowTimeWithDayFormat() {
    return getTimeWithDayFormat(time: _getNow());
  }

  /// ex: 2022-10-18
  String getTimeWithDayFormat({DateTime? time}) {
    return buildDataFormat(strFormat: 'yyyy-MM-dd', time: time ?? _getNow());
  }

  /// 現在時間 ex: 2022-10-18
  String getFullWithDateFormat(DateTime dateTime) {
    return buildDataFormat(strFormat: 'yyyy-MM-dd HH:mm:ss', time: dateTime);
  }

  /// 現在時間 ex: 2022-10-18
  String getFullWithDateFormat2(DateTime dateTime) {
    return buildDataFormat(strFormat: 'yyyy/MM/dd HH:mm:ss', time: dateTime);
  }

  ///MARK: 11 : 46 : 22  AM
  String getDateWith12HourInSecondFormat(DateTime time) {
    return buildDataFormat(strFormat: 'hh : mm : ss a', time: time);
  }

  ///MARK: 取得當月有幾天
  List<String> getCurrentMonthDays() {
    var year = _getNow().year;
    var month = _getNow().month;
    int days = DateTime(year, month + 1, 0).day;
    return List<String>.generate(
        days,
        (index) =>
            '$year-${NumberFormatUtil().integerTwoFormat(month)}-${NumberFormatUtil().integerTwoFormat(index + 1)}');
  }

  ///MARK: 取得當月第一天
  String getCurrentMonthFirst() {
    var year = _getNow().year;
    var month = _getNow().month;
    return '$year-${NumberFormatUtil().integerTwoFormat(month)}-${NumberFormatUtil().integerTwoFormat(1)}';
  }

  ///MARK: 取得當月第一天的星期
  int getCurrentMonthFirstWeek() {
    DateTime day = DateTime.parse('${getCurrentMonthFirst()} 00:00:00');
    return day.weekday;
  }

  ///MARK: 取得當月最後一天
  String getCurrentMonthLast() {
    var year = _getNow().year;
    var month = _getNow().month;
    int days = DateTime(year, month + 1, 0).day;
    return '$year-${NumberFormatUtil().integerTwoFormat(month)}-${NumberFormatUtil().integerTwoFormat(days)}';
  }

  ///MARK: 取得當月最後一天的星期
  int getCurrentMonthLastWeek() {
    DateTime day = DateTime.parse('${getCurrentMonthLast()} 00:00:00');
    return day.weekday;
  }

  ///MARK: 取得前一個月的倒數第N天
  String getPreMonthLastDay(int day) {
    DateTime monthFirstDay = DateTime.parse('${getCurrentMonthFirst()} 00:00:00');
    DateTime dateTime = monthFirstDay.subtract(Duration(days: day));
    return buildDataFormat(strFormat: 'yyyy-MM-dd', time: dateTime);
  }

  ///MARK: 取得後一個月的第N天
  String getNextMonthLastDay(int day) {
    DateTime monthFirstDay = DateTime.parse('${getCurrentMonthLast()} 00:00:00');
    DateTime dateTime = monthFirstDay.add(Duration(days: day));
    return buildDataFormat(strFormat: 'yyyy-MM-dd', time: dateTime);
  }

  /// 取得前n天
  String getBeforeDays(int day) {
    DateTime dateTime = _getNow().subtract(Duration(days: day));
    return getTimeWithDayFormat(time: dateTime);
  }

  ///取得距離今天的時間差,格式為：01h 01m 01s
  String getDiffTime(DateTime time) {
    Duration duration = time.difference(_getNow());
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits((duration.inHours.remainder(24)));
    final minutes = strDigits((duration.inMinutes.remainder(60)));
    final seconds = strDigits((duration.inSeconds.remainder(60)));
    return '${hours}h ${minutes}m ${seconds}s';
  }

  //////////////message////////////
  int timeStringToMilliseconds(String time) {
    return dateFormat.parse(time).millisecondsSinceEpoch;
  }

  /// 取得現在時間的DateTime String
  String getDateTimeStringNow() {
    return dateFormat.format(DateTime.now());
  }

  /// 兩筆時間 比較是否為同一天
  bool compareSameDay(String t1, String t2) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String date1 = dateFormat.format(dateFormat.parse(t1));
    String date2 = dateFormat.format(dateFormat.parse(t2));
    return date1 == date2;
  }

  String getTimeFormat(String sTime) {
    if (sTime != '') {
      DateTime dateTime = DateTime.parse(sTime);
      sTime = DateFormat('hh:mm a').format(dateTime);
      return sTime;
    }
    return '';
  }

  String timeStamptoDate(String stamp) {
    if (stamp != '') {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(stamp));
      stamp = DateFormat('hh:mm a').format(dateTime);
      return stamp;
    }
    return '';
  }
}
