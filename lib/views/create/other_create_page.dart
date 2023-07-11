import 'package:base_project/constant/theme/app_style.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/widgets/appbar/custom_app_bar.dart';
import 'package:base_project/widgets/label/common_network_image.dart';
import 'package:base_project/widgets/label/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/global_data.dart';
import '../../constant/theme/ui_define.dart';
import '../../models/http/data/popular_create_data.dart';
import '../../view_models/create/create_main_view_model.dart';
import '../../widgets/custom_loading_widget.dart';
import '../common_scaffold.dart';

class OtherCreatePage extends ConsumerStatefulWidget {
  const OtherCreatePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _OtherCreatePageState();
}

class _OtherCreatePageState extends ConsumerState<OtherCreatePage> with TickerProviderStateMixin {
  late TabController _tabController;
  late CreateMainViewModel viewModel;

  List list = [];

  ///最近創建
  List<PopularCreateData> get recentList => ref.watch(popularCreateDataProvider);
  String get recentChooseId =>  ref.watch(popularSelectIdProvider);
  ///熱門創建
  List<PopularCreateData> get hotList => ref.watch(hotCreateDataProvider);
  String get hotChooseId =>  ref.watch(hotSelectIdProvider);


  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    viewModel = CreateMainViewModel(ref);
    viewModel.selectData.clear();
    Future.delayed(
      Duration(milliseconds: 100),
    ).then((value) {
      ref.read(popularSelectIdProvider.notifier).update((state) => "");
      ref.read(hotSelectIdProvider.notifier).update((state) => "");
      viewModel.getPrompt();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: CustomAppBar.popularCreateAppBar(ref, context, title: "tryOtherCreate".tr(), actionWord: "apply".tr(),
          pressApply: () {
        viewModel.applyAi(context);
      }),
      body: (isDark) => Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: UIDefine.getPixelHeight(13), bottom: UIDefine.getPixelHeight(8)),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "otherCreaterMessage".tr(),
                    textAlign: TextAlign.center,
                    style: AppTextStyle.getBaseStyle(
                      color: AppColors.textWhiteOpacity5,
                      fontSize: UIDefine.fontSize13,
                    ),
                  ),
                ),
              ),
              _buildTabBar(context),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: UIDefine.getPixelHeight(16)),
                  child: Container(
                    child: _buildTabBarView(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _tabView(
            list: recentList,
            onTapCallback: (int index){
              final item = recentList[index];
              if (ref.watch(hotSelectIdProvider.notifier).state.isNotEmpty) {
                ref.read(hotSelectIdProvider.notifier).update((state) => "");
                ref.read(popularSelectIdProvider.notifier).update((state) => item.id);
              } else {
                ref.read(popularSelectIdProvider.notifier).update((state) => item.id);
              }
              viewModel.selectData = item.feature;
              print("after: ${viewModel.selectData}");
              print("item: ${item.prompt}");
              print("typeis: ${item.prompt.runtimeType}");
          },
          id: recentChooseId
        ),
        _tabView(
            list: hotList,
            onTapCallback: (int index){
              final item = hotList[index];
              if (ref.watch(popularSelectIdProvider.notifier).state.isNotEmpty) {
                ref.read(popularSelectIdProvider.notifier).update((state) => "");
                ref.read(hotSelectIdProvider.notifier).update((state) => item.id);
              } else {
                ref.read(hotSelectIdProvider.notifier).update((state) => item.id);
              }
              viewModel.selectData = item.feature;
            },
            id: hotChooseId
        ),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      height: UIDefine.getPixelHeight(36),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withOpacity(0.2),
              width: 1.0,
            ),
          )),
      child: TabBar(
        labelStyle: TextStyle(fontSize: UIDefine.fontSize14),
        indicator: UnderlineTabIndicator(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 2, color: AppColors.mainThemeButton.getColor()),
            insets: EdgeInsets.symmetric(horizontal: UIDefine.getScreenWidth(28))),
        controller: _tabController,
        tabs: viewModel.tabs.map((e) => Tab(text: e)).toList(),
      ),
    );
  }

  Widget _tabView({required List<PopularCreateData> list, required void Function(int) onTapCallback, required String id}){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: UIDefine.getPixelWidth(203),
          mainAxisSpacing: UIDefine.getPixelWidth(8),
          crossAxisSpacing: UIDefine.getPixelWidth(8),
        ),
        itemCount: list.length,
        itemBuilder: (BuildContext context, index) {
          final item = list[index];
          return GestureDetector(
              onTap: () {
                onTapCallback(index);
              },
              child:
              Stack(
                children: [
                  SizedBox(
                    width: UIDefine.getWidth(),
                    child: CommonNetworkImage(
                        fit: BoxFit.fitWidth,
                        imageUrl: "${GlobalData.urlPrefix}${item.imgUrl}",
                        loadWidget: CustomLoadingWidget(
                          width: UIDefine.getWidth(),
                          height: UIDefine.getPixelWidth(300),
                        )),
                  ),
                  Positioned(
                    top: UIDefine.getPixelWidth(4),
                    right: UIDefine.getPixelWidth(4),
                    child:  Container(
                      height: UIDefine.getPixelWidth(32),
                      width: UIDefine.getPixelWidth(32),
                      child: id == item.id
                          ? Image.asset(
                        AppImagePath.choose,fit: BoxFit.contain,
                      )
                          : Image.asset(AppImagePath.unChoose,fit: BoxFit.contain,),
                    ),)
                ],
              )
          );
        });
  }
}
