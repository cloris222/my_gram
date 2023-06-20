import 'dart:ui';

import 'package:base_project/constant/extension/int_extension.dart';
import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/widgets/button/text_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../constant/theme/app_gradient_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../models/http/data/dynamic_info_data.dart';
import '../../utils/number_format_util.dart';
import '../../view_models/call_back_function.dart';
import '../../widgets/circlie_avatar_widget.dart';
import '../../widgets/label/common_network_image.dart';
import '../../widgets/label/custom_gradient_icon.dart';
import '../personal/personal_home_page.dart';

class DynamicInfoView extends StatefulWidget {
  DynamicInfoView({
    Key? key,
    required this.data,
    required this.index,
    required this.onFollowing,
    required this.showFullContext,
    required this.showLessContext,
    required this.onLike,
    required this.onComment,
    required this.onStore,
    required this.onShare
  }) : super(key: key);
final DynamicInfoData data;
final int index;
final onGetIntFunction showFullContext;
  final onGetIntFunction showLessContext;
final onGetIntFunction onFollowing;
final onGetIntFunction onLike;
final onGetIntFunction onComment;
final onGetIntFunction onStore;
final onGetIntFunction onShare;
  @override
  State<DynamicInfoView> createState() => _DynamicInfoViewState();
}

class _DynamicInfoViewState extends State<DynamicInfoView> {
  BaseViewModel viewModel = BaseViewModel();
  int currentIndex = 0;
  double _left = 0.0;

  @override
  void didChangeDependencies() {
    setState(() {

    });
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: UIDefine.getWidth(),
          height: UIDefine.getViewHeight()*0.85,
          // color: Colors.blue,
        ),
        Positioned(
            top:0,child: _buildPhotoImage()),
        Positioned(
            bottom: UIDefine.getViewHeight()*0.1,
            left: 0,
            right: 0,
            child: _buildInfoCard()),
        Positioned(
            bottom: UIDefine.getViewHeight()*0.04,
            left: UIDefine.getPixelWidth(10),
            right: UIDefine.getPixelWidth(10),
            child: _buildActionButtons())
      ],
    );
  }

  Widget _buildPhotoImage(){
    return GestureDetector(
      onTapUp: _onTapUp,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Stack(
        children: [
          Container(
            // color: Colors.red,
            width: UIDefine.getWidth(),
            height: UIDefine.getHeight()*0.6,
          ),
          Container(
            width: UIDefine.getWidth(),
            height: UIDefine.getHeight()*0.6,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(15)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(15)),
              child: CommonNetworkImage(
                imageUrl: widget.data.images[currentIndex],
                width: UIDefine.getWidth(),
                height: UIDefine.getHeight()*0.6,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
              left: UIDefine.getPixelWidth(90),
              right: UIDefine.getPixelWidth(90),
              top: UIDefine.getPixelWidth(15),
              child: _buildImageIndex()),
        ],
      ),
    );
  }

  Widget _buildImageIndex() {
    return Row(
      children: List<Widget>.generate(widget.data.images.length, (index) {
        bool isCurrent = currentIndex == index;
        return Expanded(
            child: Container(
              height: UIDefine.getPixelWidth(2),
              decoration: AppStyle().styleColorsRadiusBackground(
                  radius: 1,
                  color: isCurrent
                      ? Colors.white.withOpacity(0.6)
                      : const Color(0xFFE2E2E2).withOpacity(0.13)),
              margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
            ));
      }),
    );
  }

  Widget _buildInfoCard(){
    return ClipRRect(
      borderRadius:BorderRadius.circular(15),
      child: Container(
        width: UIDefine.getWidth(),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15)
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(UIDefine.getPixelWidth(15)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatarWidget(imageUrl: widget.data.avatar,),
                        SizedBox(width: UIDefine.getPixelWidth(10),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.data.name,style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16,fontWeight: FontWeight.w500),),
                            SizedBox(height:  UIDefine.getPixelWidth(3),),
                            Text(_getTime(widget.data.time),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize10,fontWeight: FontWeight.w500,color: AppColors.textPrimary),)
                          ],
                        ),
                      ],
                    ),
                    Text(tr('following'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14,fontWeight: FontWeight.w400),)
                  ],
                ),
                SizedBox(height: UIDefine.getPixelWidth(15),),
                widget.data.isShowMore?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.data.context,style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14,fontWeight: FontWeight.w300),),
                    GestureDetector(
                        onTap: (){
                          widget.showLessContext(widget.index);
                        },
                        child: Text(tr('hide'),style: AppTextStyle.getBaseStyle(color: AppColors.bolderGrey),))
                  ],
                ):
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: UIDefine.getWidth()*0.8,
                      child: Wrap(
                        children: [
                          Text(
                            widget.data.context,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14,fontWeight: FontWeight.w300)
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        widget.showFullContext(widget.index);
                      },
                        child: Text(tr('seeMore'),style: AppTextStyle.getBaseStyle(color: AppColors.bolderGrey),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(String icon, {int? number}){
    return Container(
      padding: EdgeInsets.symmetric(vertical:UIDefine.getPixelWidth(2),horizontal:UIDefine.getPixelWidth(4) ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.buttonCommon.getColor().withOpacity(0.5),width: 1),
        color: AppColors.buttonCommon.getColor().withOpacity(0.3)
      ),
      child:
      number==null?
      Image.asset(icon):
      Row(
        children: [
          Image.asset(icon),
          Text(NumberFormatUtil().numberCompatFormat(number.toString()),style: AppTextStyle.getBaseStyle(fontSize:UIDefine.fontSize12,fontWeight: FontWeight.w400),)
        ],
      ),
    );
  }

  Widget _buildActionButtons(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildIconButton(AppImagePath.heartIcon,number: widget.data.likes),
            SizedBox(width: UIDefine.getPixelWidth(10),),
            _buildIconButton(AppImagePath.commentIcon,number: widget.data.comments),
          ],
        ),
        Row(
          children: [
            _buildIconButton(AppImagePath.storeIcon),
            SizedBox(width: UIDefine.getPixelWidth(10),),
            _buildIconButton(AppImagePath.moreIcon),
          ],
        )
      ],
    );
  }

  void _onTapUp(TapUpDetails details) {
    if (details.localPosition.dx / UIDefine.getWidth() >= 0.5) {
      ///圖片是否已經到最底
      if (currentIndex + 1 < widget.data.images.length) {
        setState(() {
          currentIndex += 1;
        });
      }
    } else {
      ///圖片是否已經到最前面
      if (currentIndex - 1 >= 0) {
        setState(() {
          currentIndex -= 1;
        });
      }
    }
  }

  void _onPanUpdate(DragUpdateDetails tapInfo){
    setState(() {
      _left = tapInfo.delta.dx;
      print('_left=${_left}');
    });
  }

  void _onPanEnd(DragEndDetails tapInfo){
    if(_left/ UIDefine.getWidth() >= 0.0){
      _onSwipeRight();
    }else{
      _onSwipeLeft();


    }
  }


  void _onSwipeLeft() {
    setState(() {
      if (currentIndex < widget.data.images.length - 1) {
        currentIndex++;
      }
    });
  }

  void _onSwipeRight() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
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
