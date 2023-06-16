import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/views/dynamic/dynamic_main_page.dart';
import 'package:base_project/views/explore/explore_main_page.dart';
import 'package:base_project/views/message/message_main_page.dart';
import 'package:base_project/views/pair/pair_main_page.dart';
import 'package:base_project/views/personal/personal_main_page.dart';
import 'package:flutter/material.dart';

import '../../views/personal/personal_home_page.dart';


enum AppNavigationBarType {
  typeDynamic(label: "dynamic",icon:AppImagePath.dynamicIcon,onIcon: AppImagePath.onDynamicIcon, typePage: DynamicMainPage()),
  typeExplore(label: "explore",icon:AppImagePath.exploreIcon,onIcon: AppImagePath.onExploreIcon, typePage:ExploreMainPage()),
  typePair(label: "pair",icon:AppImagePath.matchIcon,onIcon: AppImagePath.onMatchIcon, typePage: PairMainPage()),
  typeMessage(label: "message",icon:AppImagePath.chatIcon,onIcon: AppImagePath.onChatIcon, typePage: MessageMainPage()),
  typePersonal(label: "personal",icon:AppImagePath.createIcon,onIcon: AppImagePath.onCreateIcon, typePage: PersonalMainPage());

  /// 名稱
  final String label;
  /// 對應的頁面
  final Widget typePage;

  final String icon;
  final String onIcon;

  const AppNavigationBarType({
    required this.label,
    required this.typePage,
    required this.icon,
    required this.onIcon
  });
}
