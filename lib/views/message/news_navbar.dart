import 'package:base_project/constant/enum/border_style_type.dart';
import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_style.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/widgets/label/common_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../models/data/user_friends_data.dart';
import '../../models/parameter/pair_image_data.dart';

class NewsNavbar extends StatefulWidget {
  List<PairImageData> pairList;
  bool haveCeateGF;

  NewsNavbar({
    Key? key,
    required this.pairList,
    required this.haveCeateGF
  }) : super(key: key);

  @override
  State<NewsNavbar> createState() => _NewsNavbarState();
}

class _NewsNavbarState extends State<NewsNavbar> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
        itemCount: widget.pairList.length,
        itemBuilder: (context,index){
          return Column(
            children: [
              Container(
                height: UIDefine.getPixelWidth(80),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    widget.pairList[index].isMyGF?
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(5)),
                      width: UIDefine.getPixelWidth(70),
                      height: UIDefine.getPixelWidth(70),
                      decoration: AppStyle().buildGradientBorderWithGradientColor(
                        borderWidth: 3,
                        type: GradientBorderType.common,
                        colors: AppColors.gradientColors,
                        radius:15,
                      ),
                    ):
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(5)),
                      width: UIDefine.getPixelWidth(70),
                      height: UIDefine.getPixelWidth(70),
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CommonNetworkImage(
                            fit: BoxFit.cover,
                            width: UIDefine.getPixelWidth(66),
                            height: UIDefine.getPixelWidth(66),
                            imageUrl: widget.pairList[index].images[0])
                    ),
                    Visibility(
                        visible: widget.pairList[index].isMyGF==true&&widget.haveCeateGF==true,
                        child: Positioned(
                            right: 0,
                            bottom: 0,
                            width: UIDefine.getPixelWidth(25),
                            height: UIDefine.getPixelWidth(25),
                            child: Image.asset(AppImagePath.demoImage)))
                  ],
                ),
              ),
              SizedBox(height: UIDefine.getPixelWidth(5),),
              widget.pairList[index].isMyGF?
                  Text(widget.pairList[index].name,style: AppTextStyle.getGradientStyle(),):
                  Text(widget.pairList[index].name,style: AppTextStyle.getBaseStyle(),)
            ],
          );
        });
  }
}
