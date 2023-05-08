import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../constant/theme/app_text_style.dart';
import '../../models/data/user_friends_data.dart';
import 'message_list_view.dart';
import 'news_navbar.dart';

class MessageMainPage extends StatefulWidget {
  const MessageMainPage({Key? key}) : super(key: key);

  @override
  State<MessageMainPage> createState() => _MessageMainPageState();
}

class _MessageMainPageState extends State<MessageMainPage> {
  bool bDownloading = true;
  List<UserFriensData> list = [];

  @override
  void initState() {
    list.addAll(GlobalData.generateUserFriendsData(10));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
        onNotification: (scrollEnd){
          final metrics = scrollEnd.metrics;
          if (metrics.atEdge) {
            bool isTop = metrics.pixels == 0;
            if (isTop) {
              GlobalData.printLog('At the top');
            } else {
              GlobalData.printLog('At the bottom');
              if (!bDownloading) {
                // 防止短時間載入過多造成OOM
                bDownloading = true;
                // _updateView();
              }
            }
          }
          return true;
        },
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: UIDefine.getPixelWidth(5),),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: UIDefine.getPixelWidth(100),
                  child: NewsNavbar(friendsList: _sortData(list),),
                ),
              ),
              SizedBox(height: UIDefine.getPixelWidth(10),),
              Text(tr('message'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16),),
              SizedBox(height: UIDefine.getPixelWidth(20),),
              Container(
                width: UIDefine.getWidth(),
                child: MessageListView(),
              )
            ],
          ),
        )

    );
  }

  List<UserFriensData> _sortData(List<UserFriensData> list){
    List<UserFriensData> pinData = list.where((el) => el.isPin).toList();
    List<UserFriensData> unpPinData = list.where((el) => !el.isPin).toList();
    return [...pinData, ...unpPinData];
  }
}


