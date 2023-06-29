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
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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



  @override
  void initState() {
    data.posts=PitchDataUtil().buildSelfPostData();
    data.avatar=PitchDataUtil().getAvatar(MyGramAI.Rebecca);
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        backgroundColor: Colors.transparent,
        body: (isDark) => Container(
              width: UIDefine.getWidth(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: UIDefine.getWidth(),
                      height: UIDefine.getViewHeight() - UIDefine.getPixelWidth(120),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: UIDefine.getWidth(),
                            height: UIDefine.getHeight(),
                          ),
                          CommonNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: data.posts[selectedCardIndex].images[0],
                            width: UIDefine.getWidth(),
                            height: UIDefine.getViewHeight() - UIDefine.getPixelWidth(120),
                          ),
                          Positioned(
                              top: UIDefine.getStatusBarHeight(),
                              left: UIDefine.getPixelWidth(10),
                              right: UIDefine.getPixelWidth(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                 GestureDetector(
                                   onTap:(){
                                    // Navigator.pop(context);
                                   BaseViewModel().changeMainScreenPage( AppNavigationBarType.typePair);
                                   },
                                     child: Container(
                                         width: UIDefine.getPixelWidth(24),
                                         height: UIDefine.getPixelWidth(24),
                                         child: Image.asset(AppImagePath.arrowLeft,fit: BoxFit.fill,))),
                                  Expanded(child: Container()),
                                  Text(
                                    'Rebecca',
                                    style: AppTextStyle.getBaseStyle(
                                        fontSize: UIDefine.fontSize16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(child: Container()),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: UIDefine.getPixelWidth(30),
                                        height: UIDefine.getPixelWidth(30),
                                        child: Image.asset(AppImagePath.hotIcon,fit: BoxFit.fill,)),
                                  )
                                ],
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
                      decoration:BoxDecoration(
                          image: DecorationImage(image: AssetImage(AppImagePath.gradientBg),fit: BoxFit.fill)
                      ),
                      child: Container(
                        width: UIDefine.getWidth(),
                        padding: EdgeInsets.all(UIDefine.getPixelWidth(15)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildButton(),
                            _buildTabBar(),
                            _buildTabView()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget _buildSwiperCards(){
    return Container(
      height: UIDefine.getPixelWidth(150),alignment: Alignment.bottomCenter,
      // color: Colors.blue,
      child: Swiper(
        itemCount: data.posts.length,
        index: selectedCardIndex,
        onIndexChanged: (index) {
          setState(() {
            selectedCardIndex = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          bool isCenter = selectedCardIndex == index;
          // double horizontalPadding = isCenter?0:UIDefine.getPixelWidth(2.5);
          double horizontalPadding = 0;
          double topPadding = isCenter?0:UIDefine.getPixelWidth(20);

          double imageWidth = isCenter?UIDefine.getPixelWidth(200):UIDefine.getPixelWidth(160);
          double imageHeight = isCenter?UIDefine.getPixelWidth(130):UIDefine.getPixelWidth(110);
          return GestureDetector(
            onTap: (){
              if(isCenter){
                ref.read(isRebeccaProvider.notifier).update((state) => true);
                BaseViewModel().changeMainScreenPage( AppNavigationBarType.typeDynamic,isRebecca: true,index: index);
              }
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(2)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: UIDefine.getPixelWidth(200),
                      height: UIDefine.getPixelWidth(130),
                    ),
                    Positioned(
                      left: horizontalPadding,
                      right: horizontalPadding,
                      top: topPadding,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: imageWidth,
                          height: imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CommonNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: data.posts[index].images[0],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: horizontalPadding,
                      right: horizontalPadding,
                      top: topPadding,
                      bottom: 0,
                      child: Visibility(
                        visible: isCenter,
                        child: Container(
                          width: imageWidth,
                          height: imageHeight,
                          clipBehavior: Clip.antiAlias,
                          // margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(1)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:Border.all(
                                  color: AppColors.mainThemeButton.getColor(),width: 2,strokeAlign: BorderSide.strokeAlignCenter)
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: horizontalPadding,
                      right: horizontalPadding,
                      top: topPadding,
                      bottom: 0,
                      child: Visibility(
                        visible: !isCenter,
                        child: Container(
                          width: imageWidth,
                          height: imageHeight,
                          clipBehavior: Clip.antiAlias,
                          // margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(1)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withOpacity(0.3)
                          ),
                        ),
                      ),
                    ),
                    // Positioned(child: Center(child: Text("$index"),)),
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
    return SizedBox(
      width: UIDefine.getWidth() * 0.9,
      // height: UIDefine.getPixelWidth(45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: UIDefine.getPixelWidth(15),
          ),
          Expanded(
            child: TextButtonWidget(
              backgroundVertical:0,
              backgroundHorizontal: 0,
              setHeight: UIDefine.getPixelWidth(40),
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
            width: UIDefine.getPixelWidth(20),
          ),
          Expanded(
            child: TextButtonWidget(
              backgroundVertical:0,
              backgroundHorizontal: 0,
              setHeight: UIDefine.getPixelWidth(40),
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
          SizedBox(
            width: UIDefine.getPixelWidth(15),
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
                width: 3.0, color: AppColors.mainThemeButton.getColor()),
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
              height: UIDefine.getPixelWidth(40),
              child: Container(
                alignment: Alignment.center,
                height: 40,
                child: Text( tr('aboutMe')),
              ),
            ),
            Tab(
              height: UIDefine.getPixelWidth(40),
              child: Container(
                alignment: Alignment.center,
                height: 40,
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
          width: UIDefine.getWidth()*0.9,
          padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      padding: EdgeInsets.symmetric(vertical:UIDefine.getPixelWidth(20),horizontal: UIDefine.getPixelWidth(15)),
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
                    child: Text(data.link!,style: AppTextStyle.getBaseStyle(color: AppColors.textLink,fontSize: UIDefine.fontSize14,fontWeight: FontWeight.w400),),
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
