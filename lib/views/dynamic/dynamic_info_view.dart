import 'dart:ui' as ui;
import 'package:base_project/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../constant/enum/app_param_enum.dart';
import '../../constant/theme/app_style.dart';
import '../../models/http/data/dynamic_info_data.dart';
import '../../utils/number_format_util.dart';
import '../../view_models/call_back_function.dart';
import '../../widgets/circlie_avatar_widget.dart';
import '../../widgets/custom_paint_text.dart';
import '../../widgets/label/common_network_image.dart';
import '../../widgets/label/custom_gradient_icon.dart';
import '../personal/personal_home_page.dart';
import 'package:flutter/rendering.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

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
  final PageController controller = PageController();
  late final Canvas canvas;
  int lineCount = 0;
  final textStyle = AppTextStyle.getBaseStyle(
    fontSize: UIDefine.fontSize14,
    fontWeight: FontWeight.w300,
  );
  final maxWidth = UIDefine.getWidth() - UIDefine.getPixelWidth(30);

  List<Image> preImages = [];

  @override
  void initState() {
    /// 預載
    for (var element in widget.data.images) {
      preImages.add(Image.asset(element, width: UIDefine.getWidth(),
        height: UIDefine.getHeight() * 0.6,
        fit: BoxFit.cover));
    }

    Future.delayed(Duration.zero, () {
      setState(() {
        lineCount = getLineCount(widget.data.context, textStyle, maxWidth);
        for(var element in preImages){
          precacheImage(element.image, context);
        }
      });
    });
    super.initState();
  }


 @override
  void didUpdateWidget(covariant DynamicInfoView oldWidget) {
   setState(() {
     preImages=[];
     /// 預載
     for (var element in widget.data.images) {
       preImages.add(Image.asset(element, width: UIDefine.getWidth(),
           height: UIDefine.getHeight() * 0.6,
           fit: BoxFit.cover));
     }

     Future.delayed(Duration.zero, () {
       setState(() {
         lineCount = getLineCount(widget.data.context, textStyle, maxWidth);
         for(var element in preImages){
           precacheImage(element.image, context);
         }
       });
     });
   });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
            child: Container(
              width: UIDefine.getWidth(),
              child: Row(
                children: [
                  _buildInfoCard(),
                ],
              ),
            )),
        Positioned(
            bottom: UIDefine.getViewHeight()*0.04,
            left: UIDefine.getPixelWidth(10),
            right: UIDefine.getPixelWidth(10),
            child: _buildActionButtons())
      ],
    );
  }

  Widget _buildImageView(){
    return Container(
      width: UIDefine.getWidth(),
      height: UIDefine.getHeight()*0.6,
      child: PageView(
        controller: controller,
        onPageChanged: (int index){
          setState(() {
            currentIndex = index;
          });
        },
        children: List<Widget>.generate(widget.data.images.length, (index){
          return Container(
            width: UIDefine.getWidth(),
            height: UIDefine.getHeight()*0.6,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(15)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(15)),
              child: preImages[index]
              // CommonNetworkImage(
              //   imageUrl: widget.data.images[index],
              //   width: UIDefine.getWidth(),
              //   height: UIDefine.getHeight()*0.6,
              //   fit: BoxFit.cover,
              // ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPhotoImage(){
    return GestureDetector(
      onTapUp: _onTapUp,
      child: Stack(
        children: [
          Container(
            // color: Colors.red,
            width: UIDefine.getWidth(),
            height: UIDefine.getHeight()*0.6,
          ),
          _buildImageView(),
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
    return Visibility(
      visible: widget.data.images.length>=2,
      child: Row(
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
      ),
    );
  }

  Widget _buildInfoCard(){
    return Container(
      width: UIDefine.getWidth(),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: AppColors.dynamicButtonsBorder.getColor().withOpacity(0.1),
          borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(15))
      ),
      child: GlassContainer(
        width: UIDefine.getWidth(),
        border: 0.0,
        blur: 5,
        linearGradient: LinearGradient(
            colors: [AppColors.dynamicButtons.getColor().withOpacity(0.2),AppColors.dynamicButtons.getColor().withOpacity(0.2)]
        ),
        borderRadius: BorderRadius.circular(UIDefine.getPixelWidth(15)),
        child: Container(
          padding: EdgeInsets.all(UIDefine.getPixelWidth(15)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            viewModel.pushPage(context, MainScreen(type:AppNavigationBarType.typePersonal));
                          },
                          child: CircleAvatarWidget(imageUrl: widget.data.avatar,)),
                      SizedBox(width: UIDefine.getPixelWidth(10),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: (){
                                viewModel.pushPage(context, MainScreen(type:AppNavigationBarType.typePersonal));
                              },
                              child: Text(widget.data.name,style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16,fontWeight: FontWeight.w500),)),
                          SizedBox(height:  UIDefine.getPixelWidth(1),),
                          Text(_getTime(widget.data.time),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize10,fontWeight: FontWeight.w500,color: AppColors.textDetail),)
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
                  Visibility(
                    visible: lineCount>=3,
                    child: GestureDetector(
                        onTap: (){
                          widget.showLessContext(widget.index);
                        },
                        child: Text(tr('hide'),style: AppTextStyle.getBaseStyle(color: AppColors.textDetail),)),
                  )
                ],
              ):
              lineCount>=3?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Wrap(
                      children: [
                        Text(
                            widget.data.context,
                            maxLines: 2,
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
                      child: Text(tr('seeMore'),style: AppTextStyle.getBaseStyle(color: AppColors.textDetail),))
                ],
              ):
              Text(widget.data.context,style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14,fontWeight: FontWeight.w300),),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(String icon, {int? number}){
    return Container(
      padding: EdgeInsets.symmetric(vertical:UIDefine.getPixelWidth(3),horizontal:UIDefine.getPixelWidth(8) ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.dynamicButtonsBorder.getColor().withOpacity(0.1),width: 1),
        color: AppColors.dynamicButtons.getColor().withOpacity(0.5)
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
          currentIndex++;
          controller.animateToPage(
            currentIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        });
      }
    } else {
      ///圖片是否已經到最前面
      if (currentIndex - 1 >= 0) {
        setState(() {
          currentIndex--;
          controller.animateToPage(
            currentIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        });
      }
    }
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

  int getLineCount(String text, TextStyle style, double maxWidth) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: null,
      textDirection: ui.TextDirection.ltr,
    );
    textPainter.layout(maxWidth: maxWidth);
    // print('linecount=${textPainter.computeLineMetrics().length}');
    return textPainter.computeLineMetrics().length;
  }



}
