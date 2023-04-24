import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum DemoStatus {
  ///定義每個enum的參數
  init(value: 0, label: "wait", color: Color(0xffb4b4b4)),
  loading(value: 1, label: "loading", color: Color(0xfff79d8c)),
  update(value: 2, label: "update", color: Color(0xff00b9f1)),
  finish(value: 3, label: "finish", color: Color(0xff2699f6)),
  cancel(value: -1, label: "cancel", color: Color(0xff75d239));

  /// 對應數值
  final int value;
  /// 對應文字
  final String label;
  /// 對應顏色
  final Color color;

  const DemoStatus({
    required this.value,
    required this.label,
    required this.color,
  });

  ///將字串轉型成enum
  static DemoStatus parse(String type) {
    for (var element in DemoStatus.values) {
      if (type == element.name) {
        return element;
      }
    }
    return DemoStatus.values.first;
  }
}
