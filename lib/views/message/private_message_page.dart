import 'dart:io';

import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/widgets/appbar/custom_app_bar.dart';
import 'package:base_project/widgets/label/common_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../constant/theme/ui_define.dart';
import '../../models/data/chat_room_data.dart';
import '../../view_models/message/chat_room_provider.dart';
import 'gallery_view.dart';

class PrivateMessagePage extends ConsumerStatefulWidget {
  final ChatRoomData data;
  const PrivateMessagePage({
    Key? key,
    required this.data
  }) : super(key: key);

  @override
  ConsumerState createState() => _PrivateMessagePageState();
}

class _PrivateMessagePageState extends ConsumerState<PrivateMessagePage> {
  bool showGallery = false;
  bool sendImage = false;
  late PermissionState ps = PermissionState.notDetermined;
  final TextEditingController _textController = TextEditingController();
  List<AssetEntity> get imageList => ref.read(chatRoomProvider).imageList;
  List<AssetEntity> showImageList = [];

  @override
  void didUpdateWidget(covariant PrivateMessagePage oldWidget) {
    setState(() {

    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(chatRoomProvider);
    return GestureDetector(
      onTap: (){
        BaseViewModel().clearAllFocus();
      },
      child: Scaffold(
          appBar: CustomAppBar.chatRoomAppBar(context, nickName: widget.data.nickName,avatar: widget.data.avatar),
          body: Container(
            width: UIDefine.getWidth(),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  color: Colors.black,
                ),
                Column(
                  children: [
                    Expanded(
                      child: showImageList.isNotEmpty?
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: showImageList.length,
                              itemBuilder: (context,index){
                                return AssetEntityImage(
                                  showImageList[index],
                                  width: UIDefine.getPixelWidth(200),
                                  height: UIDefine.getPixelWidth(200),
                                );

                          }):
                          Container()
                    ),
                    _getBottomNavigationBar()
                  ],
                ),
              ],
            ),
          ),
          // bottomNavigationBar: _getBottomNavigationBar()
      )
    );
  }

  _getBottomNavigationBar(){
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: showGallery?UIDefine.getHeight()*0.4:UIDefine.getPixelWidth(40),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(right:UIDefine.getPixelWidth(8),bottom: UIDefine.getPixelWidth(5)),
              width: UIDefine.getWidth(),
              height: UIDefine.getPixelWidth(40),
              decoration: const BoxDecoration(
                  color: AppColors.dialogBackground,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 0, offset: Offset(0, 0),
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top:UIDefine.getPixelWidth(7)),
                    width: UIDefine.getWidth()*0.85,
                    height: UIDefine.getPixelWidth(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14), color: AppColors.dialogBackground,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ///工具列
                        SizedBox(width: UIDefine.getPixelWidth(10)),
                        InkWell(
                            onTap: () {

                            },
                            child: Icon(Icons.add)
                        ),
                        ///拍照
                        SizedBox(width: UIDefine.getPixelWidth(10)),
                        InkWell(
                            onTap: () {

                            },
                            child: Icon(Icons.photo_camera)
                        ),
                        ///相簿
                        SizedBox(width: UIDefine.getPixelWidth(10)),
                        InkWell(
                            onTap: () {
                              _openGallery();
                            },
                            child: Icon(Icons.photo)
                        ),
                        SizedBox(width: UIDefine.getPixelWidth(10)),
                        ///輸入框
                        Flexible(
                            child: Container(
                              padding: EdgeInsets.only(bottom: UIDefine.getPixelWidth(2)),
                              child: TextField(
                                // focusNode: _focusNode,
                                controller: _textController,
                                style: TextStyle(
                                    color: AppColors.textBlack,
                                    fontSize: UIDefine.fontSize12),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: tr('writeAMessage'),
                                  hintStyle: TextStyle(
                                      fontSize: UIDefine.fontSize12,
                                      color: AppColors.textWhite),
                                  fillColor: AppColors.bolderGrey, filled: true,
                                ),
                              ),)
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top:UIDefine.getPixelWidth(5)),
                    child: InkWell(
                        onTap: () {
                          _sendMessage();
                        },
                        child: Icon(Icons.send)
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: Visibility(
              visible: showGallery,
                child: Column(children: [
                        Divider(height: 1.0,),
                        Expanded(
                          child: Container(
                            width: UIDefine.getWidth(),
                              child: GalleryView(ps:ps,)
                                  ),
                                )
                            ],)
                          ),
                )
          ],
        )
      )
    );
  }

  Future<void>_openGallery()async{
    await _getPermission();
    setState(() {
      showGallery = !showGallery;
    });
  }

  Future<PermissionState>_getPermission()async{
    ps = await PhotoManager.requestPermissionExtend();
    return ps;
  }

  _sendMessage(){
    if(imageList==[]) return;
    setState(() {
      _sendImage().then((value) => ref.read(chatRoomProvider.notifier).clearImageList());
      sendImage = false;
    });
  }

  Future<void>_sendImage()async{
    setState(() {
      showImageList.addAll(imageList);
    });
  }
}
