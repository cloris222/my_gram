import 'package:base_project/constant/enum/app_param_enum.dart';
import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/models/http/data/personal_info_data.dart';
import 'package:base_project/models/http/data/post_info_data.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/views/main_screen.dart';
import 'package:base_project/views/personal/personal_info_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_models/dynmaic/is_rebecca_provider.dart';
import '../../widgets/button/text_button_widget.dart';
import '../../widgets/label/avatar_icon_widget.dart';
import '../../widgets/label/common_network_image.dart';
import '../common_scaffold.dart';
import 'package:card_swiper/card_swiper.dart';

import '../dynamic/dynamic_main_page.dart';

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
    totalPosts: 15,
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
    link: 'http://youtube.com/teresa4523',
    introduce:
        'texttexttexttexttexttextvtexttexttexttextcontextcontextcontextcontextcontextcontextcontexttexttexttexttexttexttextvtexttexttexttextcontextcontextcontextcontextcontextcontextcontext',
  );



  @override
  void initState() {
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
                    Container(
                      width: UIDefine.getWidth(),
                      height: UIDefine.getViewHeight() * 0.65,
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
                            height: UIDefine.getViewHeight() * 0.65,
                          ),
                          Positioned(
                              top: UIDefine.getHeight() * 0.07,
                              left: UIDefine.getPixelWidth(10),
                              right: UIDefine.getPixelWidth(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                 GestureDetector(
                                   onTap:(){
                                    Navigator.pop(context);
                                   },
                                     child: Image.asset(AppImagePath.arrowLeft)),
                                  Text(
                                    'Rebecca',
                                    style: AppTextStyle.getBaseStyle(
                                        fontSize: UIDefine.fontSize16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Image.asset(AppImagePath.hotIcon),
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
                      padding: EdgeInsets.all(UIDefine.getPixelWidth(15)),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        AppColors.personalDarkBackground.getColor(),
                        AppColors.personalLightBackground.getColor()
                      ])),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildButton(),
                          _buildTabBar(),
                          _buildTabView()
                        ],
                      ),
                    )
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
          return GestureDetector(
            onTap: (){
              if(selectedCardIndex == index){
                ref.read(isRebeccaProvider.notifier).update((state) => true);
                BaseViewModel().pushPage(context, MainScreen(type: AppNavigationBarType.typeDynamic,));
              }
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // color: Colors.red,
                margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(2)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: UIDefine.getPixelWidth(200),
                      height: UIDefine.getPixelWidth(130),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: index==selectedCardIndex?0:UIDefine.getPixelWidth(20),
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: index==selectedCardIndex?UIDefine.getPixelWidth(200):UIDefine.getPixelWidth(130),
                          height: index==selectedCardIndex?UIDefine.getPixelWidth(120):UIDefine.getPixelWidth(110),
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
                      left: 0,
                      right: 0,
                      top: index==selectedCardIndex?0:UIDefine.getPixelWidth(20),
                      bottom: 0,
                      child: Visibility(
                        visible: index==selectedCardIndex,
                        child: Container(
                          width: index==selectedCardIndex?UIDefine.getPixelWidth(200):UIDefine.getPixelWidth(130),
                          height: index==selectedCardIndex?UIDefine.getPixelWidth(120):UIDefine.getPixelWidth(110),
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(1)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:Border.all(
                                  color: AppColors.mainThemeButton.getColor(),width: 2,strokeAlign: BorderSide.strokeAlignOutside)
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: index==selectedCardIndex?0:UIDefine.getPixelWidth(20),
                      bottom: 0,
                      child: Visibility(
                        visible: index!=selectedCardIndex,
                        child: Container(
                          width: index==selectedCardIndex?UIDefine.getPixelWidth(200):UIDefine.getPixelWidth(130),
                          height: index==selectedCardIndex?UIDefine.getPixelWidth(120):UIDefine.getPixelWidth(110),
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(1)),
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
    return Container(
      width: UIDefine.getWidth() * 0.9,
      height: UIDefine.getPixelWidth(40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: UIDefine.getPixelWidth(15),
          ),
          Expanded(
            child: TextButtonWidget(
              isFillWidth: true,
              btnText: tr('following'),
              setMainColor: AppColors.buttonCommon,
              textColor: AppColors.textPrimary,
              onPressed: () {},
            ),
          ),
          SizedBox(
            width: UIDefine.getPixelWidth(20),
          ),
          Expanded(
            child: TextButtonWidget(
              isFillWidth: true,
              isGradient: true,
              btnText: tr('message'),
              textColor: AppColors.textBlack,
              onPressed: () {},
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
    return TabBar(
        labelPadding: EdgeInsets.zero,
        controller: _tabController,
        padding: EdgeInsets.symmetric(horizontal: 15),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
              width: 4.0, color: AppColors.mainThemeButton.getColor()),
          // 调整指示器的高度
          insets: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(100)), // 调整指示器的左右间距
        ),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        labelStyle: AppTextStyle.getBaseStyle(
            fontSize: UIDefine.fontSize14,
            fontWeight: FontWeight.w600),
        unselectedLabelStyle: AppTextStyle.getBaseStyle(
            fontSize: UIDefine.fontSize14,
            fontWeight: FontWeight.w400,
            color: AppColors.bolderGrey),
        tabs: [
          Tab(
            height: UIDefine.getPixelWidth(40),
            child: Container(
              alignment: Alignment.center,
                   height: 40,
                   decoration: const BoxDecoration(
                       color: Colors.transparent,
                       border: Border(
                         bottom: BorderSide(
                           color: Colors.grey,
                           width: 1.0,
                         ),
                       )),
              child: Text( tr('aboutMe')),
            ),
          ),
          Tab(
            height: UIDefine.getPixelWidth(40),
            child: Container(
              alignment: Alignment.center,
              height: 40,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  )),
              child: Text( tr('allPost')),
            ),
          ),
        ]);
  }

  Widget _buildTabView(){
    return Container(
      height: UIDefine.getHeight()*0.5,
      child: TabBarView(
          controller: _tabController,
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
                  Text(data.totalPosts.toString(),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize20,fontWeight: FontWeight.w600),),
                  Text(tr('posts'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14,fontWeight: FontWeight.w400,color: AppColors.bolderGrey),),
                ],
              ),
              Container(
                width: UIDefine.getPixelWidth(1),
                height: UIDefine.getPixelWidth(30),
                color: AppColors.bolderGrey.getColor(),
              ),
              Column(
                children: [
                  Text(data.fans.length.toString(),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize20,fontWeight: FontWeight.w600),),
                  Text(tr('fans'),style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14,fontWeight: FontWeight.w400,color: AppColors.bolderGrey),),
                ],
              )
            ],
          ),
        ),
        _buildInfoCard()
      ],
    );
  }

  Widget _buildInfoCard(){
    return Container(
      width: UIDefine.getWidth()*0.85,
      padding: EdgeInsets.all(UIDefine.getPixelWidth(20)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.bolderGrey.getColor().withOpacity(0.2)
      ),
      child: Column(
        children: [
          Text(data.introduce,style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14,fontWeight: FontWeight.w400),),
          SizedBox(height: UIDefine.getPixelWidth(10),),
          Visibility(
            visible: data.link!=null,
            child: Row(
              children: [
                Image.asset(AppImagePath.linkIcon),
                GestureDetector(
                  onTap: (){},
                  child: Text(data.link!,style: AppTextStyle.getBaseStyle(color: AppColors.textLink,fontSize: UIDefine.fontSize14,fontWeight: FontWeight.w400),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
