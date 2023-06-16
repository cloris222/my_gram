import 'dart:math';

import 'package:base_project/constant/theme/app_style.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:flutter/material.dart';

import '../../constant/enum/pair_enum.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_gradient_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../models/http/data/pair_image_data.dart';

import '../../widgets/label/common_network_image.dart';

class SwipeImageView extends StatefulWidget {
  const SwipeImageView({
    Key? key,
    required this.data,
    required this.onRemove,
    this.toggleRate = 0.1,
  }) : super(key: key);
  final PairImageData data;
  final double toggleRate;
  final void Function(PairImageData data, GramSetStatus status) onRemove;

  @override
  State<SwipeImageView> createState() => _SwipeImageViewState();
}

class _SwipeImageViewState extends State<SwipeImageView>
    with SingleTickerProviderStateMixin {
  PairImageData get data => widget.data;

  /// 圖片狀態
  GramSetStatus status = GramSetStatus.none;

  ///觸發時，避免連續點擊按鈕
  bool isToggle = false;

  ///切換圖片用
  int currentIndex = 0;

  ///圖片滑動用
  double _left = 0;
  double _top = 0;
  double _total = 0;
  double _angle = 0;
  final double _maxAngle = 30 * (pi / 180);
  double _scale = 0.9;
  double _difference = 40;
  bool _tapOnTop = false;

  late AnimationController _animationController;
  late Animation<double> _leftAnimation;
  late Animation<double> _topAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _differenceAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _animationController.addListener(_onAnimationListener);
    _animationController.addStatusListener(_onAnimationStatusListener);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.removeListener(_onAnimationListener);
    _animationController.removeStatusListener(_onAnimationStatusListener);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: UIDefine.getWidth(),
          height: UIDefine.getViewHeight(),
        ),
        Positioned(
          left: _left,
          top: _top,
          child: Transform.rotate(
            angle: _angle,
            child: GestureDetector(
              /// 判斷觸碰點，是否要切換上下分頁
              onTapUp: _onTapUp,

              /// 監聽滑動
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,

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
                          left: UIDefine.getPixelWidth(25),
                          right: UIDefine.getPixelWidth(25),
                          top: UIDefine.getPixelWidth(40),
                          child: _buildImageIndex()),

                      ///漸層遮罩
                      Positioned(
                        top: UIDefine.getViewHeight() * 0.6,
                        child: Container(
                          width: UIDefine.getWidth(),
                          height: UIDefine.getViewHeight() * 0.4,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment(0.0, -0.9),
                                  end: Alignment(0.0, 0.1),
                                  colors: [Colors.transparent, Colors.black])),
                        ),
                      ),

                      ///不喜歡的icon顯示
                      Positioned(
                          top: UIDefine.getPixelWidth(100),
                          right: UIDefine.getPixelWidth(15),
                          child: Visibility(
                              visible: status == GramSetStatus.disLike,
                              child: Image.asset(AppImagePath.imgDislike))),

                      ///喜歡的icon顯示
                      Positioned(
                          top: UIDefine.getPixelWidth(100),
                          left: UIDefine.getPixelWidth(15),
                          child: Visibility(
                              visible: status == GramSetStatus.like,
                              child: Image.asset(AppImagePath.imgLike))),

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
                                    // shadowsType: AppTextShadows.common,
                                  )),
                              Text(data.context,
                                  style: AppTextStyle.getBaseStyle(
                                    fontSize: UIDefine.fontSize18,
                                    fontWeight: FontWeight.w400,
                                    // shadowsType: AppTextShadows.common,
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
            bottom: UIDefine.getPixelWidth(25),
            right: UIDefine.getPixelWidth(20),
            left: UIDefine.getPixelWidth(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () => _buttonAnimate(false),
                    child: status == GramSetStatus.disLike
                        ? Container(
                            width: UIDefine.getPixelWidth(50),
                            height: UIDefine.getPixelWidth(50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColors.buttonDisLike
                                    .getColor()
                                    .withOpacity(0.8)),
                            child: Image.asset(AppImagePath.btnDislike),
                          )
                        : Container(
                            width: UIDefine.getPixelWidth(50),
                            height: UIDefine.getPixelWidth(50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColors.buttonCommon
                                    .getColor()
                                    .withOpacity(0.5)),
                            child: Image.asset(AppImagePath.btnDislike),
                          )),
                SizedBox(width: UIDefine.getPixelWidth(40)),
                GestureDetector(
                    onTap: () => _buttonAnimate(true),
                    child: status == GramSetStatus.like
                        ? Container(
                            width: UIDefine.getPixelWidth(50),
                            height: UIDefine.getPixelWidth(50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: LinearGradient(
                                    colors: AppGradientColors.gradientColors
                                        .getColors())),
                            child: Image.asset(
                              AppImagePath.btnLike,
                              color: Colors.white,
                            ),
                          )
                        : Container(
                            width: UIDefine.getPixelWidth(50),
                            height: UIDefine.getPixelWidth(50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColors.buttonCommon
                                    .getColor()
                                    .withOpacity(0.5)),
                            child: Image.asset(AppImagePath.btnLike),
                          )),
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
          height: UIDefine.getPixelWidth(2),
          decoration: AppStyle().styleColorsRadiusBackground(
              radius: 1,
              color: isCurrent
                  ? Colors.white.withOpacity(0.6)
                  : const Color(0xFFE2E2E2).withOpacity(0.13)),
          margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
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

  /// 檢查滑動停止的動作
  void _onHorizontalEnd(DragEndDetails details) {
    switch (status) {
      case GramSetStatus.none:
        {
          ///MARK:復歸
          _onBack();
        }
        break;
      case GramSetStatus.like:
      case GramSetStatus.disLike:
        {
          /// 滑動移出頁面
          _buttonAnimate(status == GramSetStatus.like);
        }
        break;
    }
  }

  void _buttonAnimate(bool isLike) async {
    if (!isToggle) {
      isToggle = true;
      status = isLike ? GramSetStatus.like : GramSetStatus.disLike;

      _leftAnimation = Tween<double>(
        begin: _left,
        end: isLike
            ? MediaQuery.of(context).size.width
            : -MediaQuery.of(context).size.width,
      ).animate(_animationController);
      _topAnimation = Tween<double>(
        begin: _top,
        end: MediaQuery.of(context).size.width * 0.1,
      ).animate(_animationController);
      _scaleAnimation = Tween<double>(
        begin: _scale,
        end: 1.0,
      ).animate(_animationController);
      _differenceAnimation = Tween<double>(
        begin: _difference,
        end: 0,
      ).animate(_animationController);
      _animationController.forward();
    }
  }

  void _onPanStart(DragStartDetails tapInfo) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset position = renderBox.globalToLocal(tapInfo.globalPosition);

    if (position.dy < renderBox.size.height / 2) _tapOnTop = true;
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

  void _onPanUpdate(DragUpdateDetails tapInfo) {
    setState(() {
      _left += tapInfo.delta.dx;
      _top += tapInfo.delta.dy;
      _total = _left + _top;
      _calculateAngle();
      _calculateScale();
      _calculateDifference();
      status = checkStatus();
    });
  }

  void _onPanEnd(DragEndDetails tapInfo) {
    _tapOnTop = false;
    _onEndAnimation(tapInfo);
  }

  void _calculateAngle() {
    if (_angle <= _maxAngle && _angle >= -_maxAngle) {
      (_tapOnTop == true)
          ? _angle = (_maxAngle / 100) * (_left / 10)
          : _angle = (_maxAngle / 100) * (_left / 10) * -1;
    }
  }

  void _calculateScale() {
    if (_scale <= 1.0 && _scale >= 0.9) {
      _scale =
          (_total > 0) ? 0.9 + (_total / 5000) : 0.9 + -1 * (_total / 5000);
    }
  }

  void _calculateDifference() {
    if (_difference >= 0 && _difference <= _difference) {
      _difference = (_total > 0) ? 40 - (_total / 10) : 40 + (_total / 10);
    }
  }

  void _onEndAnimation(DragEndDetails tapInfo) {
    _onHorizontalEnd(tapInfo);
  }

  //moves the card back to starting position
  void _onBack() {
    setState(() {
      _leftAnimation = Tween<double>(
        begin: _left,
        end: 0,
      ).animate(_animationController);
      _topAnimation = Tween<double>(
        begin: _top,
        end: 0,
      ).animate(_animationController);
      _scaleAnimation = Tween<double>(
        begin: _scale,
        end: 0.9,
      ).animate(_animationController);
      _differenceAnimation = Tween<double>(
        begin: _difference,
        end: 40,
      ).animate(_animationController);
      _animationController.forward();
    });
  }

  void _onAnimationListener() {
    if (_animationController.status == AnimationStatus.forward) {
      setState(() {
        _left = _leftAnimation.value;
        _top = _topAnimation.value;
        _scale = _scaleAnimation.value;
        _difference = _differenceAnimation.value;
      });
    }
  }

  void _onAnimationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (this.status != GramSetStatus.none) {
        widget.onRemove(data, this.status);
      } else {
        _animationController.reset();
        setState(() {
          _left = 0;
          _top = 0;
          _total = 0;
          _angle = 0;
          _scale = 0.9;
          _difference = 40;
        });
      }
    }
  }
}
