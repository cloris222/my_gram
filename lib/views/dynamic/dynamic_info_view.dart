import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/widgets/button/text_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/data/dynamic_info_data.dart';
import '../../view_models/call_back_function.dart';
import '../../widgets/label/common_network_image.dart';

class DynamicInfoView extends StatefulWidget {
  const DynamicInfoView({
    Key? key,
    required this.data,
    required this.index,
    required this.onFollowing,
    required this.showFullContext,
    required this.onLike,
    required this.onComment,
    this.showMore = false
  }) : super(key: key);
final DynamicInfoData data;
final int index;
final onGetIntFunction showFullContext;
final onGetIntFunction onFollowing;
final onGetIntFunction onLike;
final onGetIntFunction onComment;
final bool showMore;
  @override
  State<DynamicInfoView> createState() => _DynamicInfoViewState();
}

class _DynamicInfoViewState extends State<DynamicInfoView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///頭像,時間,名字,追蹤btn
        Container(
          padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(5)),
          width: UIDefine.getWidth(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            CommonNetworkImage(
                imageUrl: widget.data.avatar,
                width: UIDefine.getPixelWidth(40),
                height: UIDefine.getPixelWidth(40),
                fit: BoxFit.cover),
            Column(
              children: [
                Text(widget.data.name,style: AppTextStyle.getBaseStyle(),),
                Text(widget.data.time,style: AppTextStyle.getBaseStyle(color: AppColors.textGrey),),
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
        ///發文內容,更多btn
        Container(
          padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(10)),
          width: UIDefine.getWidth(),
          child: Row(
            children: [
              widget.showMore?
                  Text(widget.data.context,style:AppTextStyle.getBaseStyle(),):
                  Text(widget.data.context,style: AppTextStyle.getBaseStyle(),maxLines: 2,),
              GestureDetector(
                onTap: (){
                  widget.showFullContext(widget.index);
                },
                child: Visibility(
                  visible: !widget.showMore,
                  child: Text(tr('showMore')),
                ),
              )
            ],
          ),
        ),
        ///大圖
        CommonNetworkImage(
            imageUrl: widget.data.images[0],
            width: UIDefine.getWidth(),
            height: UIDefine.getPixelWidth(400),
            fit: BoxFit.cover),
        Container(
          padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(5)),
          width: UIDefine.getWidth(),
          child: Row(
            children: [
              TextButtonWidget(
                  isFillWidth: false,
                  setWidth: UIDefine.getPixelWidth(80),
                  isBorderGradient: true,
                  isBorderStyle: true,
                  btnText: widget.data.likes,
                  onPressed: (){
                    widget.onLike(widget.index);
                  }),
            ],
          ),
        )
      ],
    );
  }
}
