import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/call_back_function.dart';
import 'package:base_project/widgets/label/common_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../models/data/chat_room_data.dart';

class MessageListView extends StatefulWidget {
  final onGetIntFunction onLongPress;
  final onGetIntFunction onTap;
  final List<ChatRoomData> list;
  final onGetIntFunction onPin;
  final onGetIntFunction onDelete;
  final onGetIntFunction onMute;
  final onGetIntFunction onMarkRead;
  final bool haveCreateGF;
  const MessageListView({
    Key? key,
    required this.list,
    required this.onLongPress,
    required this.onTap,
    required this.onPin,
    required this.onDelete,
    required this.onMute,
    required this.onMarkRead,
    required this.haveCreateGF
  }) : super(key: key);

  @override
  State<MessageListView> createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {

  @override
  void didUpdateWidget(covariant MessageListView oldWidget) {
    setState(() {

    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.list.length,
        itemBuilder: (context,index){
          return GestureDetector(
              onLongPress: (){
                widget.onLongPress(index);
              },
              onTap: (){
                widget.onTap(index);
              },
              child: Slidable(
                key: const ValueKey(0),

                ///左滑
                startActionPane: ActionPane(
                  motion: const BehindMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_){
                        widget.onPin(index);
                      },
                      backgroundColor: AppColors.mainThemeButton.getColor(),
                      foregroundColor: AppColors.textPrimary.getColor(),
                      label: tr('pin'),
                    ),
                    SlidableAction(
                      onPressed: (_){
                        widget.onMute(index);
                      },
                      backgroundColor: AppColors.messageBackground.getColor(),
                      foregroundColor: AppColors.textPrimary.getColor(),
                      label: tr('mute'),
                    ),
                  ],
                ),

                ///右滑
                endActionPane: ActionPane(
                  motion: const  BehindMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_){
                        widget.onMarkRead(index);
                      },
                      backgroundColor: AppColors.mainThemeButton.getColor(),
                      foregroundColor: Colors.white,
                      label: tr('markRead'),
                    ),
                    SlidableAction(
                      onPressed: (_){
                        widget.onDelete(index);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      label: tr('delete'),
                    ),
                  ],
                ),
                child:
                Container(
                    color: AppColors.mainBackground.getColor(),
                    width: UIDefine.getWidth(),
                    padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
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
                                imageUrl: widget.list[index].avatar,
                              ),
                            ),
                            SizedBox(width: UIDefine.getPixelWidth(10),),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: UIDefine.getPixelWidth(20),
                                  child: Row(
                                    children: [
                                      Text(widget.list[index].nickName,style: AppTextStyle.getBaseStyle(),),
                                      SizedBox(width: UIDefine.getPixelWidth(10),),
                                      Text(_getTime(widget.list[index].time),
                                        style: AppTextStyle.getBaseStyle(
                                          fontSize: UIDefine.fontSize12,
                                          color: AppColors.textSubInfo,
                                        ),)
                                    ],
                                  ),
                                ),
                                SizedBox(height: UIDefine.getPixelWidth(5),),
                                Row(children: [
                                  Visibility(
                                      visible: widget.list[index].beRead == true,
                                      child: Icon(Icons.reply,color: AppColors.textSubInfo.getColor(),size: UIDefine.getPixelWidth(10),)),
                                  Container(
                                    width: UIDefine.getPixelWidth(200),
                                    child: Text(widget.list[index].content,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: AppTextStyle.getBaseStyle(
                                          fontSize: UIDefine.fontSize14,
                                          fontWeight: (widget.list[index].isRead || widget.list[index].beRead)?FontWeight.w500:FontWeight.w700,
                                          color: (widget.list[index].isRead || widget.list[index].beRead)?AppColors.textSubInfo:AppColors.textPrimary,
                                        )
                                    ),
                                  ),
                                ],)
                              ],
                            ),
                          ],
                        ),
                        Visibility(
                            visible: widget.list[index].isRead == false && widget.list[index].beRead == false,
                            child:Icon(Icons.fiber_manual_record,color: AppColors.mainThemeButton.getColor(),size: UIDefine.getPixelWidth(15),))
                      ],
                    )
                ),
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
