import 'dart:io';

import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/view_models/gobal_provider/global_tag_controller_provider.dart';
import 'package:base_project/widgets/appbar/custom_app_bar.dart';
import 'package:base_project/widgets/list_view/base_list_interface.dart';
import 'package:base_project/widgets/list_view/dynmaic/comment_item_view.dart';
import 'package:base_project/widgets/text_field/login_text_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../models/parameter/post_comment_data.dart';

class DynamicPostCommentPage extends StatefulWidget {
  const DynamicPostCommentPage({
    Key? key,
    required this.postId,
  }) : super(key: key);
  final String postId;

  @override
  State<DynamicPostCommentPage> createState() => _DynamicPostCommentPageState();
}

class _DynamicPostCommentPageState extends State<DynamicPostCommentPage>
    with BaseListInterface {
  TextEditingController controller = TextEditingController();
  final String tagEdit = "tagCommentEdit";

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar.titleAppBar(context, title: tr("commentTitle")),
      body: GestureDetector(
        // 使空白處可以點擊
        behavior: HitTestBehavior.translucent,
        onTap: () => BaseViewModel().clearAllFocus(),
        child: Column(
          children: [
            Expanded(
              child: Container(
                  decoration: AppStyle().styleColorBorderBottomLine(
                      color: AppColors.mainThemeButton),
                  child: buildListView()),
            ),

            /// 新增留言Bar
            _buildCommentBar(),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return CommentItemView(key: UniqueKey(), data: data);
  }

  @override
  Widget buildSeparatorBuilder(int index) {
    return SizedBox(height: UIDefine.getPixelWidth(10));
  }

  @override
  Widget? buildTopView() {
    return null;
  }

  @override
  changeDataFromJson(json) {
    return PostCommentData.fromJson(json);
  }

  @override
  Future<List> loadData(int page, int size) async {
    if (page <= 2) {
      return GlobalData.generateCommentData(page, size, true);
    }
    return [];
  }

  @override
  void loadingFinish() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  bool needSave(int page) {
    return false;
  }

  @override
  String setKey() {
    return "";
  }

  @override
  bool setUserTemporaryValue() {
    return false;
  }

  Widget _buildCommentBar() {
    return Container(
        color: Colors.black,
        padding: EdgeInsets.only(
            right: UIDefine.getPixelWidth(10),
            left: UIDefine.getPixelWidth(10),
            top: UIDefine.getPixelWidth(10),
            bottom: UIDefine.getPixelWidth(Platform.isIOS ? 15 : 5)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: AppStyle().styleColorsRadiusBackground(radius: 5),
                width: UIDefine.getPixelWidth(40),
                height: UIDefine.getPixelWidth(40),
                child: Image.network(
                  GlobalData.photos.first,
                  fit: BoxFit.cover,
                )),
            SizedBox(width: UIDefine.getPixelWidth(5)),
            Expanded(child: _buildCommentEdit())
          ],
        ));
  }

  Widget _buildCommentEdit() {
    return Consumer(
      builder: (context, ref, child) {
        return Stack(
          children: [
            LoginTextWidget(
              hintText: "新增留言",
              controller: controller,
              margin: EdgeInsets.zero,
              maxLines: ref.watch(globalIndexProvider(tagEdit)),
              onChanged: (value) {
                ///MARK: 計算行數，自動增加高度
                ref.read(globalIndexProvider(tagEdit).notifier).update(
                    (state) => (controller.text.length ~/ 25 > 5) ? 5 : null);
              },
              contentPaddingTop: UIDefine.getPixelWidth(10),
              contentPaddingBottom: UIDefine.getPixelWidth(10),
              contentPaddingLeft: UIDefine.getPixelWidth(10),
              contentPaddingRight: UIDefine.getPixelWidth(100),
            ),
            Positioned(
                top: 0,
                bottom: 0,
                right: UIDefine.getPixelWidth(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: _onPressAtUser,
                        child: const Icon(Icons.add)),
                    SizedBox(width: UIDefine.getPixelWidth(5)),
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: _onPressMood,
                        child: const Icon(Icons.mood_outlined)),
                    SizedBox(width: UIDefine.getPixelWidth(5)),
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => _onPressSend(ref),
                        child: const Icon(Icons.send)),
                  ],
                ))
          ],
        );
      },
    );
  }

  void _onPressAtUser() {}

  void _onPressMood() {}

  void _onPressSend(WidgetRef ref) {
    if (controller.text.isNotEmpty) {
      controller.text = "";
      BaseViewModel().clearAllFocus();
      ref.read(globalIndexProvider(tagEdit).notifier).update((state) => null);
    }
  }
}
