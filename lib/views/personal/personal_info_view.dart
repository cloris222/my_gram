import 'package:base_project/constant/extension/int_extension.dart';
import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_style.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/widgets/button/text_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/enum/border_style_type.dart';
import '../../constant/theme/app_gradient_colors.dart';
import '../../constant/theme/global_data.dart';
import '../../models/http/data/personal_info_data.dart';
import '../../models/http/data/post_info_data.dart';
import '../../view_models/call_back_function.dart';
import '../../widgets/label/common_network_image.dart';

class PersonalInfoView extends StatefulWidget {
  final PersonalInfoData data;
  final onClickFunction clickFollowing;
  final onClickFunction clickMessage;
  final onClickFunction clickSeeMore;

  const PersonalInfoView({
    required this.data,
    required this.clickFollowing,
    required this.clickMessage,
    required this.clickSeeMore,
    Key? key}) : super(key: key);

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {

  @override
  void didChangeDependencies() {
    setState(() {

    });
    super.didChangeDependencies();
  }

  bool bDownloading = true;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
        onNotification: (scrollEnd) {
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
            _updateView();
          }
        }
      }
      return true;
    },
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: UIDefine.getPixelWidth(10),),
        ///上方info navbar
        Container(
          width: UIDefine.getWidth()*0.9,
          margin: EdgeInsets.symmetric(
              horizontal: UIDefine.getPixelWidth(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///頭像
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      width: UIDefine.getPixelWidth(90),
                      height: UIDefine.getPixelWidth(90),
                      decoration: AppStyle().buildGradientBorderWithGradientColor(
                          radius: 20,
                          borderWidth: 2,
                          type: GradientBorderType.common,
                          colors: AppGradientColors.gradientColors.getColors()),
                      child: SizedBox()
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CommonNetworkImage(
                      fit: BoxFit.cover,
                      width: UIDefine.getPixelWidth(80),
                      height: UIDefine.getPixelWidth(80),
                      imageUrl: widget.data.avatar,
                    ),
                  )
                ],
              ),
              ///貼文
              Column(
                children: [
                  Text((widget.data.totalPosts).numberCompatFormat(),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16),),
                  Text(tr('posts'),style: AppTextStyle.getBaseStyle(color: AppColors.textSubInfo),)
                ],
              ),
              ///粉絲
              Column(
                children: [
                  Text((widget.data.fans.length).numberCompatFormat(),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16),),
                  Text(tr('fans'),style: AppTextStyle.getBaseStyle(color: AppColors.textSubInfo))
                ],
              ),
              ///聲量排行（企劃待補）
              Text(tr('rank')),
            ],
          ),
        ),
        SizedBox(height: UIDefine.getPixelWidth(10),),
        ///自介
        widget.data.isShowMore?
        Container(
            width: UIDefine.getWidth()*0.9,
            margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(10)),
            child: Wrap(
              children: [
                Text(widget.data.introduce,style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14),)
              ],
            )
        ):
        Container(
          width: UIDefine.getWidth()*0.9,
          margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
                Container(
                  margin: EdgeInsets.all(UIDefine.getPixelWidth(10)),
                  width:UIDefine.getWidth()*0.7,
                  child: Wrap(
                    children: [
                      Text(widget.data.introduce,style: AppTextStyle.getBaseStyle(),maxLines: 5,)
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: widget.clickSeeMore,
                  child: Text(tr('seeMore'),style: AppTextStyle.getBaseStyle(color: AppColors.textSubInfo),),
                )
              ],
            ),),
        SizedBox(height: UIDefine.getPixelWidth(10),),
        ///btn
        Container(
          width: UIDefine.getWidth()*0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.data.isFollowing?
              TextButtonWidget(
                setWidth: UIDefine.getPixelWidth(150),
                  setHeight: UIDefine.getPixelWidth(50),
                  radius: 4,
                  borderSize: 0.5,
                  isFillWidth: false,
                  isBorderStyle: true,
                  textColor: AppColors.textPrimary,
                  setMainColor: AppColors.textPrimary,
                  setSubColor: AppColors.transparent,
                  btnText: tr('following'),
                  onPressed: widget.clickFollowing):
              TextButtonWidget(
                  setWidth: UIDefine.getPixelWidth(150),
                  setHeight: UIDefine.getPixelWidth(50),
                  radius: 4,
                  borderSize: 0.5,
                  isFillWidth: false,
                  isGradient: true,
                  textColor: AppColors.textPrimary,
                  btnText: tr('follow'),
                  onPressed: widget.clickFollowing),
              TextButtonWidget(
                  setWidth: UIDefine.getPixelWidth(150),
                  setHeight: UIDefine.getPixelWidth(50),
                  radius: 4,
                  borderSize: 0.5,
                  isFillWidth: false,
                  isBorderStyle: true,
                  textColor:AppColors.textPrimary ,
                  setMainColor: AppColors.textPrimary,
                  setSubColor: AppColors.transparent,
                  btnText: tr('message'),
                  onPressed: widget.clickMessage)
            ],
          ),
        ),
        SizedBox(height: UIDefine.getPixelWidth(10),),
        _buildPosts(widget.data.posts),

      ],
    ),)
    );
  }

  _buildPosts(List<PostInfoData> posts){
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
        ),
        itemCount: posts.length,
        itemBuilder: (context,index){
          if(index == posts.length - 1){
            bDownloading = false;
          }
          return CommonNetworkImage(
            fit: BoxFit.cover,
            imageUrl: posts[index].images[0],
          );
        });
  }

  _updateView(){
    setState(() {
      widget.data.posts.addAll([
        PostInfoData(context: '222', images: GlobalData.photos),
        PostInfoData(context: '333', images: GlobalData.photos2),
        PostInfoData(context: '444', images: GlobalData.photos),
      ]);
    });
  }
}
