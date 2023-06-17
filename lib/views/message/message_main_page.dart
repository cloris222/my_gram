import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/views/message/more_action_bar.dart';
import 'package:base_project/views/message/private_message_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../constant/theme/app_text_style.dart';
import '../../models/http/data/chat_room_data.dart';
import '../../models/http/data/pair_image_data.dart';
import 'message_list_view.dart';
import 'news_navbar.dart';

class MessageMainPage extends StatefulWidget {
  const MessageMainPage({Key? key}) : super(key: key);

  @override
  State<MessageMainPage> createState() => _MessageMainPageState();
}

class _MessageMainPageState extends State<MessageMainPage> {
  bool bDownloading = true;
  List<PairImageData> pairList = [];
  List<ChatRoomData> list = [];
  bool haveCreateGF = false;

  @override
  void initState() {
    list = [];
    pairList = [];
    list.addAll(GlobalData.generateChatRoomData(5));
    pairList.addAll(GlobalData.generatePairImageData(10));
    _insertMyGF(haveCreateGF);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MessageMainPage oldWidget) {
    setState(() {

    });
    super.didUpdateWidget(oldWidget);
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
              ///配對到尚未聊天
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: UIDefine.getPixelWidth(110),
                  child: NewsNavbar(
                    pairList: pairList,
                    haveCeateGF: haveCreateGF,
                    onTap: (index){},
                  ),
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
                  list: _sortChat(list),
                  haveCreateGF: haveCreateGF,
                  onDelete: (index){
                    _onDeleteChat(context,index);
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
                  onTap: (index){
                    _getDataToChatRoom(context,index);
                  },
                ),
              )
            ],
          ),
        )
    );
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
              color: AppColors.dialogBackground.getColor(),
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
                    },
                  ),
                  MoreActionBar(
                    icon: Icons.visibility,
                    title: tr('markAsRead'),
                    onClick: (){
                      _markRead(index);
                    },),
                  MoreActionBar(
                    icon: Icons.delete,
                    iconColor: AppColors.buttonMessageRed,
                    title: tr('deleteChat'),
                    titleColor: AppColors.buttonMessageRed,
                    onClick: (){
                      _onDeleteChat(context,index);
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
                  color: AppColors.dialogBackground.getColor(),
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
                                  color: AppColors.textSubInfo),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: UIDefine.getPixelWidth(10),),
                      TextButton(
                          onPressed: (){
                            _deleteChat(index);
                            Navigator.pop(context);///關掉dialog
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
                          },
                          child: Text(tr('cancel'),
                            style: AppTextStyle.getBaseStyle(
                                fontSize: UIDefine.fontSize16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary),)),
                    ]),
              )
          );
        });
  }

  List<ChatRoomData> _sortChat(List<ChatRoomData> list){
    list.sort((a,b)=>(b.time).compareTo(a.time));
    List<ChatRoomData> pinChat = list.where((el) => el.isPin == true).toList();
    List<ChatRoomData> unpPinChat = list.where((el) => el.isPin != true).toList();
    this.list =  [...pinChat,...unpPinChat];
    return this.list;
  }

   _deleteChat(int index){
    setState(() {
      list.removeAt(index);
    });
  }

  _markRead(int index){
    setState(() {
      list[index].isRead = true;
    });
  }

  void _pinChat(int index){
    setState(() {
      list[index].isPin = !list[index].isPin;
    });
  }

  void _insertMyGF(bool haveCreateGF){
    if(!haveCreateGF){
      pairList.insert(0,PairImageData(
        images: GlobalData.photos,
        name: 'createMyGF',
        context: 'createMyGF',
        isMyGF: true,
      ));
    }
    else{
      pairList.insert(0,PairImageData(
        images: GlobalData.photos2,
        name: 'myGF',
        context: 'myGF',
        isMyGF: true,
      ));
    }
  }

  _getDataToChatRoom(BuildContext context,int index){
    BaseViewModel().pushPage(context, PrivateMessagePage(
      // data:list[index]
      ));
  }
}



