import 'package:base_project/views/dynamic/dynamic_main_page.dart';
import 'package:base_project/views/explore/explore_main_page.dart';
import 'package:base_project/views/message/message_main_page.dart';
import 'package:base_project/views/pair/pair_main_page.dart';
import 'package:base_project/views/personal/personal_main_page.dart';
import 'package:flutter/material.dart';


enum AppNavigationBarType {
  typeDynamic(label: "dynamic",icon: Icons.star, typePage: DynamicMainPage()),
  typeExplore(label: "explore",icon: Icons.search, typePage:ExploreMainPage()),
  typePair(label: "pair",icon: Icons.local_activity, typePage: PairMainPage()),
  typeMessage(label: "message",icon: Icons.question_answer_rounded, typePage: MessageMainPage()),
  typePersonal(label: "personal",icon: Icons.account_circle_outlined, typePage: PersonalMainPage());

  /// 名稱
  final String label;
  /// 對應的頁面
  final Widget typePage;

  final IconData icon;

  const AppNavigationBarType({
    required this.label,
    required this.typePage,
    required this.icon,
  });
}
