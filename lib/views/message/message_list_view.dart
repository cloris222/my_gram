import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/widgets/label/common_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        int finalRecordIndex = list[index].messageData.length-1;
          return Container(
            margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(list[index].name,style: AppTextStyle.getBaseStyle(),),
                            SizedBox(width: UIDefine.getPixelWidth(10),),
                            Text(_getTime(list[index].messageData[finalRecordIndex].time),
                              style: AppTextStyle.getBaseStyle(
                                fontSize: UIDefine.fontSize12,
                                color: AppColors.textGrey,
                              ),)
                          ],
                        ),
                        SizedBox(height: UIDefine.getPixelWidth(5),),
                        Text(list[index].messageData[finalRecordIndex].context[list[index].messageData[finalRecordIndex].context.length-1],
                            style:
                            AppTextStyle.getBaseStyle(
                              fontSize: UIDefine.fontSize14,
                              fontWeight: list[index].messageData[finalRecordIndex].isRead?FontWeight.w500:FontWeight.w700,
                              color: list[index].messageData[finalRecordIndex].isRead?AppColors.textGrey:AppColors.textWhite,
                            )
                        )
                      ],
                    ),
                  ],
                ),
                Visibility(
                  visible: list[index].messageData[finalRecordIndex].isRead == false,
                    child:Icon(Icons.fiber_manual_record,color: AppColors.mainThemeButton,size: UIDefine.getPixelWidth(15),))
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
