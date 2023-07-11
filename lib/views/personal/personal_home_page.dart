import 'dart:async';
import 'dart:io';

import 'package:base_project/constant/enum/app_param_enum.dart';
import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/models/http/data/personal_info_data.dart';
import 'package:base_project/models/http/data/post_info_data.dart';
import 'package:base_project/utils/pitch_data_util.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/widgets/appbar/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constant/theme/app_style.dart';
import '../../view_models/dynmaic/is_rebecca_provider.dart';
import '../../widgets/button/text_button_widget.dart';
import '../../widgets/label/common_network_image.dart';
import '../common_scaffold.dart';
import 'package:card_swiper/card_swiper.dart';


class PersonalHomePage extends ConsumerStatefulWidget {
  const PersonalHomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PersonalHomePageState();
}

class _PersonalHomePageState extends ConsumerState<PersonalHomePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;
  int selectedCardIndex = 0;

  PersonalInfoData data = PersonalInfoData(
    avatar: GlobalData.photos[0],
    name: 'bbb',
    totalPosts: 8,
    fans: ['qqq', '222', 'ttt'],
    posts: [
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos),
      PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2),
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos),
      PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2),
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos),
      PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2),
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos),
      PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2),
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos),
      PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2),
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos),
      PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2)
    ],
    link: 'https://www.instagram.com/rebecca_mygram/',
    introduce:
        "音樂家／樂團 \nPoppyCakes 主Rapper/副舞者 \nPop the world with PoppyCakes! \n#poppycakes #rebeccamusic #rapper \n#rapperlife #dance #dancerlife",
  );

  List<Image> preImages = [];
  bool isScrollDown = true;
  double opacity = 1;
  Timer? timer;
  int topIndex = 0;
  @override
  void initState() {
    data.posts=PitchDataUtil().buildSelfPostData();
    data.avatar=PitchDataUtil().getAvatar(MyGramAI.Rebecca);
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    /// 預載圖片
    for (var element in data.posts) {
      preImages.add(Image.asset(element.images.first,fit: BoxFit.cover));
    }
    Future.delayed(Duration.zero, () {
      setState(() {
        for(var element in preImages){
          precacheImage(element.image, context);
        }
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {

    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: CustomAppBar.personalAppBar(
          context,
          height: isScrollDown == true ? UIDefine.getPixelWidth(Platform.isIOS ? 102 : 96) : 0,
        ),
        body: (isDark) => Container(
              width: UIDefine.getWidth(),
              child: NotificationListener<ScrollUpdateNotification>(
                onNotification: (scrollUpdate) {
                  final metrics = scrollUpdate.metrics;
                  final scrollDelta = scrollUpdate.scrollDelta;
                  if ( metrics.pixels == 0) {
                    setState(() {
                      isScrollDown = true;
                    });
                  } else if (metrics.axis == Axis.vertical && scrollDelta! < 0) {
                    setState(() {
                      isScrollDown = true;
                    });
                  } else if (metrics.axis == Axis.vertical &&scrollDelta! > 0) {
                    setState(() {
                      isScrollDown = false;
                    });
                  }
                  return true;
                },
                child: SingleChildScrollView(
                  // padding: EdgeInsets.only(bottom: UIDefine.getNavigationBarHeight()),
                  child: Column(
                    children: [
                      SizedBox(
                        width: UIDefine.getWidth(),
                        height: UIDefine.getViewHeight() - UIDefine.getPixelWidth(140),
                        child: Stack(
                          children: [
                            SizedBox(
                              width: UIDefine.getWidth(),
                              height: UIDefine.getHeight(),
                            ),
                            // CommonNetworkImage(
                            //   fit: BoxFit.cover,
                            //   imageUrl: data.posts[selectedCardIndex].images[0],
                            //   width: UIDefine.getWidth(),
                            //   height: UIDefine.getViewHeight() - UIDefine.getPixelWidth(120),
                            // ),

                            SizedBox(
                              width: UIDefine.getWidth(),
                              height: UIDefine.getViewHeight() - UIDefine.getPixelWidth(120),
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: opacity,
                                child: preImages[topIndex],
                              ),
                            ),
                            Positioned(
                                left:0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  height:UIDefine.getPixelWidth(40),
                                  color: AppColors.textBlack.getColor(),
                                )),
                            Positioned(
                              bottom:UIDefine.getPixelWidth(1),
                                left: 0,
                                right: 0,
                                child: _buildSwiperCards())
                          ],
                        ),
                      ),
                      Container(
                        width: UIDefine.getWidth(),
                        decoration:const BoxDecoration(
                            image: DecorationImage(image: AssetImage(AppImagePath.gradientBg),fit: BoxFit.fill)
                        ),
                        child: Container(
                          width: UIDefine.getWidth(),
                          padding: EdgeInsets.symmetric(horizontal:UIDefine.getPixelWidth(20)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildButton(),
                              _buildTabBar(),
                              SizedBox(height: UIDefine.getPixelWidth(32)),
                              _buildTabView()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  void _updateIndex(int index) {
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 100), (){
      setState(() {
        topIndex = index;
        opacity = 1;
      });
    });
  }
  Widget _buildSwiperCards() {
    return Container(
      height: UIDefine.getPixelWidth(150),
      alignment: Alignment.bottomCenter,
      child: Swiper(
        itemCount: data.posts.length,
        onIndexChanged: (index) {
          setState(() {
            opacity = 0.1;
            topIndex = selectedCardIndex;
            selectedCardIndex = index;
          });
          _updateIndex(index);
        },
        itemBuilder: (BuildContext context, int index) {
          bool isCenter = selectedCardIndex == index;
          double imageWidth = isCenter ? UIDefine.getPixelWidth(96) : UIDefine.getPixelWidth(81);
          double imageHeight = isCenter ? UIDefine.getPixelWidth(128) : UIDefine.getPixelWidth(108);
          AlignmentGeometry alignment = Alignment.bottomCenter;
          double margin = 0;

          /// 判斷是左邊還是右邊
          int offsetRightIndex = (selectedCardIndex + 1) % data.posts.length;
          int offsetLeftIndex = (selectedCardIndex - 1 + data.posts.length) % data.posts.length;
          int offsetRightIndex2 = (selectedCardIndex + 2) % data.posts.length;
          int offsetLeftIndex2 = (selectedCardIndex - 2 + data.posts.length) % data.posts.length;
          if (index == offsetRightIndex) {
            alignment = Alignment.bottomRight;
            margin = UIDefine.getPixelWidth(1);
          }
          if (index == offsetLeftIndex) {
            alignment = Alignment.bottomLeft;
            margin = UIDefine.getPixelWidth(1);
          }
          if (index == offsetRightIndex2) {
            alignment = Alignment.bottomLeft;
            margin = UIDefine.getPixelWidth(2);
          }
          if (index == offsetLeftIndex2) {
            alignment = Alignment.bottomRight;
            margin = UIDefine.getPixelWidth(2);
          }

          return GestureDetector(
            onTap: () {
              if (isCenter) {
                ref.read(isRebeccaProvider.notifier).update((state) => true);
                BaseViewModel().changeMainScreenPage(AppNavigationBarType.typeDynamic, isRebecca: true, index: index);
              }
            },
            child: Align(
              alignment: alignment,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(margin)),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      width: imageWidth,
                      height: imageHeight,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        decoration: AppStyle().styleShadowBorderBackground(
                            borderBgColor: Colors.transparent, shadowColor: AppColors.textBlack.getColor().withOpacity(0.7), radius: 0, offsetX: 0, offsetY: 0, blurRadius: 10),
                        child: Container(
                          decoration: isCenter
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.mainThemeButton.getColor(), width: 2, strokeAlign: BorderSide.strokeAlignCenter))
                              : null,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: preImages[index],
                            // CommonNetworkImage(
                            //   fit: BoxFit.cover,
                            //   imageUrl: data.posts[index].images[0],
                            // ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Visibility(
                        visible: !isCenter,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black.withOpacity(0.3)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        viewportFraction: 0.23,
        // scale: 0.5,
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      width: UIDefine.getWidth(),
      padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(32)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextButtonWidget(
              backgroundVertical:0,
              backgroundHorizontal: 0,
              setHeight: UIDefine.getPixelWidth(38),
              margin: EdgeInsets.zero,
              isFillWidth: true,
              btnText: tr('following'),
              setMainColor: AppColors.buttonUnable,
              textColor: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: UIDefine.fontSize14,
              onPressed: () {},
            ),
          ),
          SizedBox(
            width: UIDefine.getPixelWidth(17),
          ),
          Expanded(
            child: TextButtonWidget(
              backgroundVertical:0,
              backgroundHorizontal: 0,
              setHeight: UIDefine.getPixelWidth(38),
              margin: EdgeInsets.zero,
              isFillWidth: true,
              isGradient: true,
              btnText: tr('message'),
              textColor: AppColors.textBlack,
              fontWeight: FontWeight.w500,
              fontSize: UIDefine.fontSize14,
              onPressed: () {
                /// 切換頁面
                BaseViewModel().changeMainScreenPage( AppNavigationBarType.typeMessage);
              },
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration:  BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withOpacity(0.2),
              width: 1.0,
            ),
          )),
      child: TabBar(
          labelPadding: EdgeInsets.zero,
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(15)),
          indicator: UnderlineTabIndicator(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
                width: 2.0, color: AppColors.mainThemeButton.getColor()),
            // 调整指示器的高度
            insets: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(100)), // 调整指示器的左右间距
          ),
          onTap: (index) {
            setState(() {
              _tabController.index=0;
              selectedIndex = 0;
            });
          },
          labelStyle: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize14,
              fontWeight: FontWeight.w500),
          unselectedLabelStyle: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize14,
              fontWeight: FontWeight.w400,
              color: AppColors.textWhiteOpacity5),
          tabs: [
            Tab(
              height: UIDefine.getPixelWidth(28),
              child: Container(
                alignment: Alignment.topCenter,
                //height: 40,
                child: Text( tr('aboutMe')),
              ),
            ),
            Tab(
              height: UIDefine.getPixelWidth(28),
              child: Container(
                alignment: Alignment.topCenter,
               // height: 40,
                child: Text( tr('allPost')),
              ),
            ),
          ]),
    );
  }

  Widget _buildTabView(){
    return SizedBox(
      height: UIDefine.getPixelWidth(350),
      child: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _aboutMeView(),
            Container()
          ]),
    );
  }

  Widget _aboutMeView(){
    return Column(
      children: [
        Container(
          width: UIDefine.getWidth(),
          padding: EdgeInsets.only(bottom: UIDefine.getPixelWidth(24),right: UIDefine.getPixelWidth(24),left: UIDefine.getPixelWidth(24)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: UIDefine.getPixelWidth(60),
                height: UIDefine.getPixelWidth(60),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CommonNetworkImage(
                    imageUrl: data.avatar,
                    width: UIDefine.getPixelWidth(60),
                    height: UIDefine.getPixelWidth(60),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  // Text(data.totalPosts.toString(),
                  Text("100",
                    style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize20,fontWeight: FontWeight.w600),),
                  Text(tr('posts'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12,fontWeight: FontWeight.w500,color:AppColors.textWhiteOpacity4),),
                ],
              ),
              Container(
                width: UIDefine.getPixelWidth(1),
                height: UIDefine.getPixelWidth(30),
                color: AppColors.bolderGrey.getColor(),
              ),
              Column(
                children: [
                  // Text(data.fans.length.toString(),
                  Text("1.9M",
                    style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize20,fontWeight: FontWeight.w600),),
                  Text(tr('fans'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12,fontWeight: FontWeight.w500,color: AppColors.textWhiteOpacity4),),
                ],
              )
            ],
          ),
        ),
        _buildInfoCard(),
      ],
    );
  }

  Widget _buildInfoCard(){
    return Container(
      width: UIDefine.getWidth(),
      padding: EdgeInsets.symmetric(vertical:UIDefine.getPixelWidth(19),horizontal: UIDefine.getPixelWidth(16)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.dynamicButtonsBorder.getColor().withOpacity(0.05),width: UIDefine.getPixelWidth(0.5)),
        color: AppColors.textWhite.getColor().withOpacity(0.08)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.introduce,textAlign: TextAlign.start,style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14,fontWeight: FontWeight.w400,height: 1.4),),
          SizedBox(height: UIDefine.getPixelWidth(15),),
          Visibility(
            visible: data.link!=null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                width: UIDefine.getPixelWidth(16),
                    height: UIDefine.getPixelWidth(16),
                    child: Image.asset(AppImagePath.linkIcon,fit: BoxFit.fill,)),
                SizedBox(width: UIDefine.getPixelWidth(8)),
                Flexible(
                  child: GestureDetector(
                    onTap: (){},
                    child: Text(data.link!,style: AppTextStyle.getBaseStyle(color: AppColors.textLink,fontSize: UIDefine.fontSize13,fontWeight: FontWeight.w400),),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }


}
