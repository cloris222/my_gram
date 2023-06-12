import 'dart:math';

import 'package:base_project/constant/extension/int_extension.dart';
import 'package:base_project/constant/theme/app_style.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/dynmaic/reply_comment_provider.dart';
import 'package:base_project/widgets/label/avatar_icon_widget.dart';
import 'package:base_project/widgets/list_view/base_list_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../models/http/data/post_comment_data.dart';

///MARK: 第一層留言用
class CommentItemView extends StatefulWidget {
  const CommentItemView({Key? key, required this.data}) : super(key: key);
  final PostCommentData data;

  @override
  State<CommentItemView> createState() => _CommentItemViewState();
}

class _CommentItemViewState extends State<CommentItemView>
    with BaseListInterface {
  PostCommentData get data => widget.data;

  /// 是否為主回應
  bool get isMain => data.isMainComment();

  @override
  void initState() {
    if (isMain) {
      /// 尚未讀取過第二層回應
      if (data.subCommentList == null) {
        init();
      }

      /// 如果已讀取過第二層回應，不再重新讀取
      else {
        setListView(data.subCommentList!);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildAvatar(),
            SizedBox(width: UIDefine.getPixelWidth(5)),
            Expanded(
                child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              runSpacing: UIDefine.getPixelWidth(5),
              children: [
                _buildCommentName(),
                _buildCommentContext(),
                Row(
                  children: [
                    _buildLikes(),
                    isMain
                        ? const SizedBox()
                        : Container(
                            margin: EdgeInsets.only(
                                left: UIDefine.getPixelWidth(10)),
                            child: _buildReply()),
                  ],
                ),
              ],
            )),
            SizedBox(width: UIDefine.getPixelWidth(5)),
            isMain
                ? Container(
                    margin: EdgeInsets.only(top: UIDefine.fontSize12),
                    child: _buildReply())
                : const SizedBox(),
          ]),
          isMain
              ? Container(
                  margin: EdgeInsets.only(top: UIDefine.getPixelWidth(5)),
                  child: buildListView(
                      physics: const NeverScrollableScrollPhysics()))
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return AvatarIconWidget(imageUrl: data.avatarUrl);
  }

  Widget _buildCommentName() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            data.userName,
            style: AppTextStyle.getBaseStyle(height: 1.1),
          ),
        ),
        SizedBox(width: UIDefine.getPixelWidth(5)),
        Text(
          "3小時前",
          style: AppTextStyle.getBaseStyle(height: 1.1),
        ),
      ],
    );
  }

  Widget _buildCommentContext() {
    return Text(
      data.commentContext,
      style: AppTextStyle.getBaseStyle(
          fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w300),
    );
  }

  Widget _buildLikes() {
    AppColors color =
        data.isLike ? AppColors.mainThemeButton : AppColors.commentUnlike;
    return GestureDetector(
      onTap: _onPressLike,
      child: Container(
        constraints: BoxConstraints(minWidth: UIDefine.getPixelWidth(60)),
        decoration: AppStyle().styleColorBorderBackground(
            radius: 25, color: color.getColor(), backgroundColor: Colors.transparent),
        padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.favorite,
                color: color.getColor(), size: UIDefine.getPixelWidth(15)),
            Text(
              data.likes.numberCompatFormat(),
              style: AppTextStyle.getBaseStyle(
                  color: color,
                  fontSize: UIDefine.fontSize12,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReply() {
    return Consumer(
      builder: (context, ref, child) {
        return GestureDetector(
            onTap: () => _onPressReply(ref),
            child: Container(
                padding: const EdgeInsets.all(3),
                color: Colors.transparent,
                child: Text("回覆", style: AppTextStyle.getBaseStyle())));
      },
    );
  }

  void _onPressReply(WidgetRef ref) {
    ref.read(replyCommentProvider.notifier).state = data;
  }

  void _onPressLike() {
    ///TODO: API 更新
    setState(() {
      data.onToggleLike();
    });
  }

  ///----- 第二層回應
  @override
  bool readAll() {
    return true;
  }

  @override
  Widget buildItemBuilder(int index, data) {
    return CommentItemView(data: data, key: UniqueKey());
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
    if (page == 1) {
      return GlobalData.generateCommentData(page, Random().nextInt(size),
          isMain: false, replyId: data.commentId);
    }
    return [];
  }

  @override
  void loadingFinish() {
    /// 觸發loading的時機代表api讀取完成，更新至第一層的subCommentList
    if (isMain) {
      data.subCommentList = currentItems.cast<PostCommentData>();
    }
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
}
