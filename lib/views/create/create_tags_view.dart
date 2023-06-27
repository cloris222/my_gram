import 'package:base_project/constant/theme/app_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/create/create_tag_provider.dart';
import 'package:base_project/widgets/button/text_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/app_colors.dart';
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

  int? get currentIndex => ref.read(globalIndexProvider(pageTag));

  @override
  Widget build(BuildContext context) {
    ref.watch(createTagProvider);
    ref.watch(globalIndexProvider(pageTag));
    return Container(
      decoration: AppStyle().styleColorBorderBackground(
          color: AppColors.mainBackground.getColor(),
          backgroundColor: AppColors.mainBackground.getColor(),
          radius: 20,
          hasBottomRight: false,
          hasBottomLef: false),
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
      padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
      child: ListView.builder(
          itemCount: tags.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            bool isSelect = (currentIndex == index);
            return TextButtonWidget(
              btnText: tr(tags[index]),
              onPressed: () {},
              isFillWidth: false,
            );
          }),
    );
  }

  Widget _buildView() {
    return SizedBox();
  }
}
