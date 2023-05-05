import 'package:base_project/constant/extension/int_extension.dart';
import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/widgets/button/text_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/data/dynamic_info_data.dart';
import '../../view_models/call_back_function.dart';
import '../../widgets/label/common_network_image.dart';
import '../../widgets/label/custom_gradient_icon.dart';
import '../personal/personal_home_page.dart';
import '../personal/personal_main_page.dart';

class DynamicInfoView extends StatefulWidget {
  DynamicInfoView({
    Key? key,
    required this.data,
    required this.index,
    required this.onFollowing,
    required this.showFullContext,
    required this.onLike,
    required this.onComment,
  }) : super(key: key);
final DynamicInfoData data;
final int index;
final onGetIntFunction showFullContext;
final onGetIntFunction onFollowing;
final onGetIntFunction onLike;
final onGetIntFunction onComment;
  @override
  State<DynamicInfoView> createState() => _DynamicInfoViewState();
}

class _DynamicInfoViewState extends State<DynamicInfoView> {
  BaseViewModel viewModel = BaseViewModel();
  @override
  void didUpdateWidget(covariant DynamicInfoView oldWidget) {
    setState(() {

    });
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///頭像,時間,名字,追蹤btn
        Container(
          padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(2)),
          width: UIDefine.getWidth(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap:(){
                      viewModel.pushPage(context, const PersonalHomePage());
                    },
                    child: CommonNetworkImage(
                        imageUrl: widget.data.avatar,
                        width: UIDefine.getPixelWidth(40),
                        height: UIDefine.getPixelWidth(40),
                        fit: BoxFit.cover),
                  ),
                  SizedBox(width: UIDefine.getPixelWidth(10),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap:(){
                          viewModel.pushPage(context, const PersonalHomePage());
                        },
                        child: Text(widget.data.name,style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14),),
                      ),
                      Text(_getTime(widget.data.time),style: AppTextStyle.getBaseStyle(color: AppColors.textGrey,fontSize: UIDefine.fontSize12),),
                    ],
                  ),
                ],
              ),
            TextButtonWidget(
              isFillWidth: false,
              setWidth: UIDefine.getPixelWidth(100),
              radius: 50,
                setMainColor: Colors.grey,
                btnText: widget.data.isFollowing?tr('following'):tr('follow'),
                onPressed: (){
                  widget.onFollowing(widget.index);
                })
          ],),
        ),
        SizedBox(height: UIDefine.getPixelWidth(10),),
        ///發文內容,更多btn
        Container(
          margin: EdgeInsets.only(left: UIDefine.getWidth()*0.1),
          padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(10)),
          width: UIDefine.getWidth()*0.9,
          child:
          widget.data.isShowMore?
          Row(
            children: [
              Container(
                width: UIDefine.getWidth()*0.8,
                child: Wrap(
                  children: [
                    Text(widget.data.context,style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14)),
                  ],
                ),
              ),
            ],
          ):
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: UIDefine.getWidth()*0.6,
                child: Wrap(
                  children: [
                    Text(widget.data.context,style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14),maxLines: 2,),
                  ],
                ),
              ),
            GestureDetector(
              onTap: (){
                widget.showFullContext(widget.index);
              },
              child: Visibility(
              visible: !widget.data.isShowMore,
              child: Text(tr('showMore'),style: AppTextStyle.getBaseStyle(color: AppColors.textGrey),),
            ),
          )
            ],
          )
        ),
        SizedBox(height: UIDefine.getPixelWidth(10),),
        ///大圖
        CommonNetworkImage(
            imageUrl: widget.data.images[0],
            width: UIDefine.getWidth(),
            height: UIDefine.getPixelWidth(300),
            fit: BoxFit.cover),
        SizedBox(height: UIDefine.getPixelWidth(10),),
        ///底下navbar
        Container(
          padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(2)),
          width: UIDefine.getWidth(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///like
              TextButton(
                style: TextButton.styleFrom(
                  shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: AppColors.mainThemeButton)
                  ),
                  foregroundColor: AppColors.mainThemeButton,
                ),
                  onPressed: ()=>widget.onLike(widget.index),
                  child: Container(
                    alignment: Alignment.center,
                    width: UIDefine.getPixelWidth(65),
                    height: 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      CustomGradientIcon(
                        icon: Icon(Icons.favorite),
                        colors: AppColors.gradientColors,
                      ),
                      SizedBox(width: UIDefine.getPixelWidth(5),),
                      Text((widget.data.likes).numberCompatFormat())
                    ],),
                  )),
              SizedBox(width:UIDefine.getPixelWidth(10)),
              ///comments
              TextButton(
                  style: TextButton.styleFrom(
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: AppColors.mainThemeButton)
                    ),
                    foregroundColor: AppColors.mainThemeButton,
                  ),
                  onPressed: ()=>widget.onComment(widget.index),
                  child: Container(
                    alignment: Alignment.center,
                    width: UIDefine.getPixelWidth(65),
                    height: 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomGradientIcon(
                          icon: Icon(Icons.sms_outlined),
                          colors: AppColors.gradientColors,
                        ),
                        SizedBox(width: UIDefine.getPixelWidth(5),),
                        Text((widget.data.comments).numberCompatFormat())
                      ],),
                  )),
              SizedBox(width:UIDefine.getPixelWidth(10)),
              ///store
              TextButton(
                  style: TextButton.styleFrom(
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: AppColors.mainThemeButton)
                    ),
                    foregroundColor: AppColors.mainThemeButton,
                  ),
                  onPressed: ()=>widget.onLike(widget.index),
                  child: Container(
                    alignment: Alignment.center,
                    width: UIDefine.getPixelWidth(65),
                    height: 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomGradientIcon(
                          icon: Icon(Icons.bookmark),
                          colors: AppColors.gradientColors,
                        ),
                      ],),
                  )),
              SizedBox(width:UIDefine.getPixelWidth(10)),
              ///share
              TextButton(
                  style: TextButton.styleFrom(
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: AppColors.mainThemeButton)
                    ),
                    foregroundColor: AppColors.mainThemeButton,
                  ),
                  onPressed: ()=>widget.onLike(widget.index),
                  child: Container(
                    alignment: Alignment.center,
                    width: UIDefine.getPixelWidth(65),
                    height: 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomGradientIcon(
                          icon: Icon(Icons.share),
                          colors: AppColors.gradientColors,
                        ),
                      ],),
                  )),
            ],
          ),
        ),
        SizedBox(height: UIDefine.getPixelWidth(10),)
      ],
    );
  }

  _getTime(String time){
    DateTime now = DateTime.now();
    DateTime publicTime = DateTime.parse(time);
    Duration duration = now.difference(publicTime);
    String dataTime;

    if(duration.inHours>= 24){
      dataTime = '${publicTime.year}年${publicTime.month}月${publicTime.day}日';
    }else{
      dataTime = '${duration.inHours}小時前';
    }
    return dataTime;
  }
}
