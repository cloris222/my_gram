import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/widgets/label/common_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../models/data/user_friends_data.dart';

class MessageListView extends StatefulWidget {
  const MessageListView({Key? key}) : super(key: key);

  @override
  State<MessageListView> createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  List<UserFriensData> list = [];

  @override
  initState(){
    list.addAll(GlobalData.generateUserFriendsData(20));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
        itemBuilder: (context,index){
          return Container(
            margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CommonNetworkImage(
                    fit: BoxFit.cover,
                    width: UIDefine.getPixelWidth(60),
                    height: UIDefine.getPixelWidth(60),
                    imageUrl: list[index].avatar,
                  ),
                ),
                SizedBox(width: UIDefine.getPixelWidth(5),),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(list[index].name,style: AppTextStyle.getBaseStyle(),),
                        Text(_getTime(list[index].messageData[list[index].messageData.length-1].time),
                          style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize12,
                            color: AppColors.textGrey,
                          ),)
                      ],
                    ),
                    Text(list[index].messageData[0].context[0],
                        style: AppTextStyle.getBaseStyle(
                          fontSize: UIDefine.fontSize12,
                          color: AppColors.textGrey,
                        ))
                  ],
                )
              ],
            )
          );
        });
  }

  _getTime(String time){
    DateTime now = DateTime.now();
    DateTime messageTime = DateTime.parse(time);
    Duration duration = now.difference(messageTime);
    String dataTime;

    if(duration.inHours>= 24){
      dataTime = '${messageTime.year}年${messageTime.month}月${messageTime.day}日';
    }else{
      dataTime = '${duration.inHours}小時前';
    }
    return dataTime;
  }
}
