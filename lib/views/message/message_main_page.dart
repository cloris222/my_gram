import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/views/message/more_action_bar.dart';
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
    list = [];
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
              ///限時動態
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: UIDefine.getPixelWidth(110),
                  child: NewsNavbar(friendsList: _sortData(list),),
                ),
              ),
              SizedBox(height: UIDefine.getPixelWidth(10),),
              Container(
                padding: EdgeInsets.only(left: UIDefine.getPixelWidth(5)),
                child: Text(tr('message'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16),),
              ),
              SizedBox(height: UIDefine.getPixelWidth(20),),
              ///訊息列
              Container(
                width: UIDefine.getWidth(),
                child: MessageListView(
                  list: list,
                  onDelete: (index){
                    setState(() {
                      _deleteChat(index);
                    });
                  },
                  onMarkRead: (index){
                    _markRead(index);
                  },
                  onMute: (index){},
                  onPin: (index){
                    _pinChat(index);
                  },
                  onLongPress:(index){
                    print('onLongPress');
                     _onLongPress(context,index).then((value) => setState((){}));
                  },
                ),
              )
            ],
          ),
        )
    );
  }

  List<UserFriensData> _sortData(List<UserFriensData> list){
    List<UserFriensData> pinData = list.where((el) => el.isPin).toList();
    List<UserFriensData> unPinData = list.where((el) => !el.isPin).toList();
    return [...pinData, ...unPinData];
  }

  _onLongPress(BuildContext context, int index) async {
    return showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:(BuildContext context, StateSetter setState)=> Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.dialogBackground,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
              ),
            ),
            height: UIDefine.getHeight()*0.4,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: UIDefine.getPixelWidth(10),),
                  MoreActionBar(
                    icon: Icons.volume_mute_outlined,
                    title: tr('muteChat'),
                    onClick: (){},
                  ),
                  MoreActionBar(
                    icon: Icons.push_pin,
                    title: tr('pinChat'),
                    onClick: (){
                      _pinChat(index);
                      Navigator.pop(context);
                    },
                  ),
                  MoreActionBar(
                    icon: Icons.visibility,
                    title: tr('markAsRead'),
                    onClick: (){
                      _markRead(index);
                      Navigator.pop(context);
                    },),
                  MoreActionBar(
                    icon: Icons.delete,
                    iconColor: Colors.red,
                    title: tr('deleteChat'),
                    titleColor: Colors.red,
                    onClick: (){
                      _onDeleteChat(context,index).then((value) => setState((){}));
                    },
                  ),
                ]),
          ),
        );
      },
    );
  }


  Future<void>_onDeleteChat(BuildContext context, int index)async{
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(15.0)), //this right here
              child:
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.dialogBackground,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                width: UIDefine.getPixelWidth(300),
                height: UIDefine.getPixelWidth(250),
                child: Column(
                    children: [
                      SizedBox(height: UIDefine.getPixelWidth(10),),
                      Wrap(
                        children: [
                          Text(
                            tr('deleteAlert'),
                            style: AppTextStyle.getBaseStyle(
                              fontSize: UIDefine.fontSize18,
                              fontWeight: FontWeight.w800,),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      SizedBox(height: UIDefine.getPixelWidth(20),),
                      Container(
                        width: UIDefine.getPixelWidth(200),
                        child: Wrap(
                          children: [
                            Text(
                              tr('deleteAlertInfo'),
                              style: AppTextStyle.getBaseStyle(
                                  fontSize: UIDefine.fontSize14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textGrey),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: UIDefine.getPixelWidth(10),),
                      TextButton(
                          onPressed: (){
                            setState(() {
                              _deleteChat(index);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });

                          },
                          child: Text(tr('ok'),
                            style: AppTextStyle.getBaseStyle(
                                fontSize: UIDefine.fontSize16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.mainThemeButton),)),
                      Divider(height: 1.0,),
                      TextButton(
                          onPressed: (){
                            Navigator.pop(context);///關掉dialog
                            Navigator.pop(context);///關掉menu
                          },
                          child: Text(tr('cancel'),
                            style: AppTextStyle.getBaseStyle(
                                fontSize: UIDefine.fontSize16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textWhite),)),
                    ]),
              )
          );
        });
  }

  _deleteChat(int index){
    list.removeAt(index);
  }

  _markRead(int index){
    setState(() {
      list[index].messageData[list[index].messageData.length-1].isRead = true;
    });
  }

  _pinChat(int index){
    setState(() {
      list[index].isPin = true;
    });
  }
}



