import 'package:base_project/constant/enum/style_enum.dart';
import 'package:base_project/constant/theme/app_style.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:flutter/material.dart';

import '../../constant/enum/pair_enum.dart';
import '../../constant/theme/app_colors.dart';
import '../../models/parameter/pair_image_data.dart';
import 'dart:math' as math;

import '../../widgets/label/common_network_image.dart';

class SwipeImageView extends StatefulWidget {
  const SwipeImageView({
    Key? key,
    required this.data,
    required this.onRemove,
    this.toggleRate = 0.25,
  }) : super(key: key);
  final PairImageData data;
  final double toggleRate;
  final void Function(PairImageData data, GramSetStatus status) onRemove;

  @override
  State<SwipeImageView> createState() => _SwipeImageViewState();
}

class _SwipeImageViewState extends State<SwipeImageView> {
  PairImageData get data => widget.data;

  /// 圖片狀態
  GramSetStatus status = GramSetStatus.none;

  ///圖片滑動用
  double _left = 0.0;

  ///觸發時，避免連續點擊按鈕
  bool isToggle = false;

  ///切換圖片用
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(width: UIDefine.getWidth(), height: UIDefine.getViewHeight()),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Transform.rotate(
            alignment: _left > 0 ? Alignment.topRight : Alignment.topLeft,
            angle: math.pi * _left / UIDefine.getWidth() / -2,
            child: GestureDetector(
              /// 判斷左右滑動，並更新畫面
              onHorizontalDragUpdate: _onHorizontalUpdate,

              /// 判斷滑動結束時，應觸發的動作
              onHorizontalDragEnd: _onHorizontalEnd,

              /// 判斷觸碰點，是否要切換上下分頁
              onTapUp: _onTapUp,

              child: Container(
                margin: EdgeInsets.all(UIDefine.getPixelWidth(5)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      ///MARK:圖片本體
                      CommonNetworkImage(
                          imageUrl: data.images[currentIndex],
                          width: UIDefine.getWidth(),
                          height: UIDefine.getViewHeight(),
                          fit: BoxFit.cover),

                      Positioned(
                          left: UIDefine.getPixelWidth(5),
                          right: UIDefine.getPixelWidth(5),
                          top: UIDefine.getPixelWidth(5),
                          child: _buildImageIndex()),

                      ///不喜歡的icon顯示
                      Positioned(
                          top: UIDefine.getPixelWidth(15),
                          right: 0,
                          child: Visibility(
                              visible: status == GramSetStatus.disLike,
                              child: Icon(Icons.close,
                                  size: UIDefine.getPixelWidth(30)))),

                      ///喜歡的icon顯示
                      Positioned(
                          top: UIDefine.getPixelWidth(15),
                          left: 0,
                          child: Visibility(
                              visible: status == GramSetStatus.like,
                              child: Icon(Icons.favorite,
                                  size: UIDefine.getPixelWidth(30)))),

                      ///自介
                      Positioned(
                          bottom: UIDefine.getPixelWidth(100),
                          left: UIDefine.getPixelWidth(15),
                          right: UIDefine.getPixelWidth(15),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.name,
                                  style: AppTextStyle.getBaseStyle(
                                    fontSize: UIDefine.fontSize36,
                                    fontWeight: FontWeight.w700,
                                    shadowsType: AppTextShadows.common,
                                  )),
                              Text(data.context,
                                  style: AppTextStyle.getBaseStyle(
                                    fontSize: UIDefine.fontSize18,
                                    fontWeight: FontWeight.w400,
                                    shadowsType: AppTextShadows.common,
                                  )),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        ///下方按鈕
        Positioned(
            bottom: UIDefine.getPixelWidth(15),
            right: UIDefine.getPixelWidth(20),
            left: UIDefine.getPixelWidth(20),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _buttonAnimate(false),
                    child: Container(
                      decoration: AppStyle().styleColorBorderBackground(
                          color: AppColors.buttonDisLike,
                          radius: 10,
                          backgroundColor: Colors.transparent,
                          borderLine: 4),
                      padding: EdgeInsets.all(UIDefine.getPixelWidth(15)),
                      child: const Icon(Icons.close,
                          color: AppColors.buttonDisLike),
                    ),
                  ),
                ),
                SizedBox(width: UIDefine.getPixelWidth(15)),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _buttonAnimate(true),
                    child: Container(
                      decoration: AppStyle().styleColorBorderBackground(
                          color: AppColors.buttonLike,
                          radius: 10,
                          backgroundColor: Colors.transparent,
                          borderLine: 4),
                      padding: EdgeInsets.all(UIDefine.getPixelWidth(15)),
                      child: const Icon(Icons.favorite,
                          color: AppColors.buttonLike),
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }

  Widget _buildImageIndex() {
    return Row(
      children: List<Widget>.generate(data.images.length, (index) {
        bool isCurrent = currentIndex == index;
        return Expanded(
            child: Container(
          height: UIDefine.getPixelWidth(5),
          decoration: AppStyle().styleColorsRadiusBackground(
              radius: 1,
              color: isCurrent
                  ? Colors.white.withOpacity(0.6)
                  : const Color(0xFFE2E2E2).withOpacity(0.13)),
          margin: const EdgeInsets.symmetric(horizontal: 0.5, vertical: 5),
        ));
      }),
    );
  }

  GramSetStatus checkStatus() {
    double rate = _left * (_left > 0 ? 1 : -1) / UIDefine.getWidth();
    if (rate >= widget.toggleRate) {
      ///MARK:代表需判斷是否要選擇
      if (_left > 0) {
        return GramSetStatus.like;
      } else {
        return GramSetStatus.disLike;
      }
    } else {
      ///MARK:復歸
      return GramSetStatus.none;
    }
  }

  void _onHorizontalUpdate(DragUpdateDetails details) {
    setState(() {
      _left += details.delta.dx;
      status = checkStatus();
    });
  }

  void _onHorizontalEnd(DragEndDetails details) {
    switch (status) {
      case GramSetStatus.none:
        {
          setState(() {
            _left = 0;
          });
        }
        break;
      case GramSetStatus.like:
      case GramSetStatus.disLike:
        {
          widget.onRemove(data, status);
        }
        break;
    }
  }

  void _buttonAnimate(bool isLike) async {
    if (!isToggle) {
      isToggle = true;
      status = isLike ? GramSetStatus.like : GramSetStatus.disLike;
      int count = (widget.toggleRate ~/ 0.01);
      while (count >= 0) {
        await Future.delayed(const Duration(milliseconds: 2));
        setState(() {
          _left += (UIDefine.getWidth() * 0.01 * (isLike ? 1 : -1));
        });
        count -= 1;
      }
      widget.onRemove(data, status);
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (details.localPosition.dx / UIDefine.getWidth() >= 0.5) {
      ///圖片是否已經到最底
      if (currentIndex + 1 < data.images.length) {
        setState(() {
          currentIndex += 1;
        });
      }
    } else {
      ///圖片是否已經到最前面
      if (currentIndex - 1 >= 0) {
        setState(() {
          currentIndex -= 1;
        });
      }
    }
  }
}
