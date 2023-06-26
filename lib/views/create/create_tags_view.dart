import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_style.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/create/create_tag_detail_provider.dart';
import 'package:base_project/view_models/create/create_tag_provider.dart';
import 'package:base_project/widgets/button/text_button_widget.dart';
import 'package:base_project/widgets/label/common_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/app_colors.dart';
import '../../models/http/data/feature_detail_data.dart';
import '../../view_models/create/create_main_view_model.dart';
import '../../view_models/gobal_provider/global_tag_controller_provider.dart';

class CreateTagsView extends ConsumerStatefulWidget {
  const CreateTagsView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateTagsViewState();
}

class _CreateTagsViewState extends ConsumerState<CreateTagsView> {
  final pageTag = "createView";

  List<String> get tags => ref.read(createTagProvider);

  int get currentTagIndex => ref.read(globalIndexProvider(pageTag)) ?? 0;

  String get currentTag => tags[currentTagIndex];

  int? get currentTagDetailIndex => ref.read(createChooseProvider(currentTag));

  @override
  Widget build(BuildContext context) {
    ref.watch(createTagProvider);
    ref.watch(globalIndexProvider(pageTag));
    for (var element in tags) {
      ref.watch(createChooseProvider(element));
    }

    return Container(
      decoration: AppStyle().styleColorBorderBackground(
          color: AppColors.mainBackground.getColor(),
          backgroundColor: AppColors.mainBackground.getColor(),
          radius: 20,
          hasBottomRight: false,
          hasBottomLef: false),
      padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
      child: Column(
        children: [
          _buildTags(),
          Expanded(child: _buildView()),
        ],
      ),
    );
  }

  Widget _buildTags() {
    return Container(
      height: UIDefine.getPixelWidth(50),
      padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: tags.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          bool isSelect = (currentTagIndex == index);
          return TextButtonWidget(
            fontSize: UIDefine.fontSize12,
            fontWeight: FontWeight.w500,
            radius: 38,
            padding: EdgeInsets.zero,
            backgroundVertical: UIDefine.getPixelWidth(6),
            backgroundHorizontal: UIDefine.getPixelWidth(3),
            margin: EdgeInsets.zero,
            btnText: tr(tags[index]),
            setMainColor:
                isSelect ? AppColors.buttonUnable : AppColors.transparent,
            onPressed: () {
              ref
                  .read(globalIndexProvider(pageTag).notifier)
                  .update((state) => index);
            },
            isFillWidth: false,
          );
        },
        separatorBuilder: (context, index) =>
            SizedBox(width: UIDefine.getPixelWidth(2)),
      ),
    );
  }

  Widget _buildView() {
    List<FeatureDetailData> list =
        ref.read(createTagDetailProvider(currentTag));
    int row = 4;
    int itemCount = (list.length ~/ row) + ((list.length % row > 0) ? 1 : 0);
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Row(
          children: List<Widget>.generate(
              row,
              (itemIndex) => Expanded(
                  child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: UIDefine.getPixelWidth(2.5)),
                      child: _buildItem(list, index * 4 + itemIndex)))),
        );
      },
      separatorBuilder: (context, index) =>
          SizedBox(height: UIDefine.getPixelWidth(5)),
    );
  }

  Widget _buildItem(List<FeatureDetailData> list, int itemIndex) {
    if (itemIndex >= list.length) {
      return const SizedBox();
    }
    var data = list[itemIndex];
    bool isSelected = currentTagDetailIndex == itemIndex;

    return GestureDetector(
      onTap: () {
        ref
            .read(createChooseProvider(currentTag).notifier)
            .update((state) => itemIndex);
      },
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          CommonNetworkImage(
            background: Colors.white,
            imageUrl: "https://test-bucket.mygram.ai/${data.imgUrl}",
            width: UIDefine.getWidth(),
            height: UIDefine.getPixelWidth(120),
            cacheWidth: 480,
            fit: BoxFit.fitHeight,
          ),

          /// 選中遮罩
          Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Visibility(
                visible: isSelected,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.8)
                      ])),
                ),
              )),

          /// 選中遮罩
          Positioned(
              top: 0,
              right: 0,
              child: Visibility(
                  visible: isSelected,
                  child: Image.asset(AppImagePath.choose))),

          /// 底部遮罩
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding:
                    EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8)
                    ])),
                child: Text(tr(data.name),
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize12,
                        fontWeight: FontWeight.w500)),
              )),
        ],
      ),
    );
  }
}
