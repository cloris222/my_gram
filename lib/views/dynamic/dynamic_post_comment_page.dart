import 'dart:io';
import 'dart:math';

import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/view_models/dynmaic/reply_comment_provider.dart';
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
import '../../models/http/data/post_comment_data.dart';
import '../../widgets/label/avatar_icon_widget.dart';
import '../common_scaffold.dart';

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
    return CommonScaffold(
      appBar: CustomAppBar.titleAppBar(context, title: tr("commentTitle")),
      body: (isDark) => GestureDetector(
        // 使空白處可以點擊
        behavior: HitTestBehavior.translucent,
        onTap: () => BaseViewModel().clearAllFocus(),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                      decoration: AppStyle().styleColorBorderBottomLine(
                          color: AppColors.mainThemeButton.getColor()),
                      child: buildListView()),
                  Positioned(
                      bottom: 0, right: 0, left: 0, child: _buildReplyView()),
                ],
              ),
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
      return GlobalData.generateCommentData(page, size, isMain: true);
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
        color: AppColors.mainBackground.getColor(),
        padding: EdgeInsets.only(
            right: UIDefine.getPixelWidth(10),
            left: UIDefine.getPixelWidth(10),
            top: UIDefine.getPixelWidth(10),
            bottom: UIDefine.getPixelWidth(Platform.isIOS ? 15 : 5)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AvatarIconWidget(imageUrl: GlobalData.photos.first),
            SizedBox(width: UIDefine.getPixelWidth(5)),
            Expanded(child: _buildCommentEdit())
          ],
        ));
  }

  Widget _buildReplyView() {
    return Consumer(builder: (context, ref, child) {
      PostCommentData? data = ref.watch(replyCommentProvider);
      if (data == null) {
        return const SizedBox();
      }

      return Opacity(
          opacity: 0.78,
          child: GestureDetector(
              onTap: () => ref.read(replyCommentProvider.notifier).state = null,
              child: Container(
                  decoration: AppStyle().styleColorBorderBackground(
                      radius: 0, color: Colors.grey),
                  padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
                  child: Text(
                    "${data.isMainComment() ? "" : "@${data.userName}"} ${data.commentContext}",
                    textAlign: TextAlign.start,
                    style: AppTextStyle.getBaseStyle(
                        color: AppColors.buttonPrimaryText),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ))));
    });
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
      /// 打ＡＰＩ
      setState(() {
        PostCommentData? replyComment = ref.read(replyCommentProvider);

        ///MARK: 代表直接回應貼文
        ///TODO: 底下的insert 應該要打api 取得第一頁第一筆資料
        if (replyComment == null) {
          currentItems.insert(
              0,
              PostCommentData(
                  replyId: "",
                  commentId: 'add_${Random().nextInt(999)}',
                  commentContext: controller.text,
                  avatarUrl: GlobalData.photos.first,
                  userName: 'user',
                  likes: 0,
                  isLike: false));
        }

        ///MARK: 代表回應留言
        else {
          /// 處理回應內容
          for (PostCommentData element in currentItems) {
            bool needInsert = false;
            if (replyComment.isMainComment()) {
              if (element.commentId.compareTo(replyComment.commentId) == 0) {
                needInsert = true;
              }
            } else {
              if (element.commentId.compareTo(replyComment.replyId) == 0) {
                needInsert = true;
              }
            }

            ///TODO: 底下的insert 應該要打api 取得第一頁第一筆資料
            if (needInsert) {
              element.subCommentList?.insert(
                  0,
                  PostCommentData(
                      replyId: element.commentId,
                      commentId: "sub_${element.commentId}",
                      commentContext:
                          "${replyComment.isMainComment() ? "" : "@${replyComment.userName} "} ${controller.text}",
                      avatarUrl: GlobalData.photos.first,
                      userName: 'user',
                      likes: 0,
                      isLike: false));
              return;
            }
          }
        }
      });

      /// 清除內容
      controller.text = "";
      BaseViewModel().clearAllFocus();
      ref.read(globalIndexProvider(tagEdit).notifier).update((state) => null);
      ref.read(replyCommentProvider.notifier).state = null;
    }
  }

  @override
  bool needEncryption() {
    return false;
  }
}
