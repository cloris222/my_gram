import 'package:flutter/material.dart';

import 'app_style.dart';
import 'app_text_style.dart';

@immutable //不可變物件
class AppTheme {
  const AppTheme._();

  static final style = AppStyle();

  static ThemeData define() {
    return ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: Colors.black,
        primaryIconTheme: const IconThemeData(color: Colors.white),
        primaryTextTheme: TextTheme(titleMedium: AppTextStyle.getBaseStyle(fontSize: 12)),
        textTheme: TextTheme(titleMedium: AppTextStyle.getBaseStyle(fontSize: 12)));
  }
}
