import 'dart:async';

import 'package:base_project/widgets/button/text_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/ui_define.dart';
import '../../view_models/call_back_function.dart';

class CountdownButtonWidget extends StatefulWidget {
  const CountdownButtonWidget(
      {Key? key,
      this.btnText = '',
      required this.onPress,
      this.countdownSecond = 180,
      this.showCountdownText = false,
      this.initEnable = true,
      this.setHeight,
      this.fontSize,
      this.margin = const EdgeInsets.only(left: 5, top: 10),
      this.padding,
      this.isFillWidth = false,
      this.onPressVerification,
      this.isGradient = false,
      this.radius})
      : super(key: key);
  final int countdownSecond; //倒數秒數
  final String btnText; //一開始顯示文字
  final bool initEnable; //一開始是否可按
  final bool showCountdownText; //倒數時是否顯示文字
  final VoidCallback onPress;
  final double? setHeight;
  final double? fontSize;
  final bool isFillWidth;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry? padding;
  final bool isGradient;
  final double? radius;

  ///檢查資料是否正確可按
  final PressVerification? onPressVerification;

  @override
  State<CountdownButtonWidget> createState() => _CountdownButtonWidgetState();
}

class _CountdownButtonWidgetState extends State<CountdownButtonWidget> {
  int _currentSecond = 0;
  late String _currentText;
  bool _enableButton = false;
  late Timer _countdownTimer;
  bool haveClicked = false;

  @override
  void initState() {
    super.initState();
    if (widget.initEnable) {
      //等待觸發後可按
      updateStatus();
    } else {
      //自動觸發
      _currentSecond = widget.countdownSecond;
      updateStatus();
      // countdownFunction();
    }
  }

  @override
  void dispose() {
    super.dispose();
    try {
      _countdownTimer.cancel();
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return _enableButton? TextButtonWidget(
      isGradient: widget.isGradient,
        setHeight: widget.setHeight,
        radius: widget.radius??10,
        btnText: _currentText,
        onPressed: () {
          haveClicked = true;
          _onPressed();
        },
        setMainColor: _enableButton ? AppColors.mainThemeButton : Colors.grey,
        setSubColor: _enableButton ? Colors.transparent : AppColors.textWhite,
        setTransColor: _enableButton ? Colors.transparent : AppColors.textWhite,
        fontSize: widget.fontSize ?? UIDefine.fontSize16,
        margin: widget.margin,
        padding: widget.padding,
        isBorderStyle: _enableButton,
        isFillWidth: widget.isFillWidth):
    TextButtonWidget(
        radius: widget.radius??10,
        setHeight: widget.setHeight,
        btnText: _currentText,
        onPressed: () {
        },
        setMainColor: _enableButton ? AppColors.mainThemeButton : Colors.grey,
        setSubColor: _enableButton ? Colors.transparent : AppColors.textWhite,
        setTransColor: Colors.transparent ,
        fontSize: widget.fontSize ?? UIDefine.fontSize16,
        margin: widget.margin,
        padding: widget.padding,
        isBorderStyle: _enableButton,
        isFillWidth: widget.isFillWidth)
    ;
  }

  Future<void> _onPressed() async {
    bool press = true;
    if (widget.onPressVerification != null) {
      press = await widget.onPressVerification!();
    }
    if (press) {
      if (widget.initEnable && _enableButton) {
        _enableButton = false;
        setState(() {
          _currentSecond = widget.countdownSecond;
          updateStatus();
        });
        countdownFunction();
        widget.onPress();
      } else if (!widget.initEnable && _enableButton) {
        widget.onPress();
      }
    }
  }

  void countdownFunction() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSecond > 0) {
        //顯示倒數
        setState(() {
          _currentSecond -= 1;
          updateStatus();
        });
      } else {
        _countdownTimer.cancel();
      }
    });
  }

  void updateStatus() {
    if(_currentSecond != 0&&!haveClicked){
      _enableButton = false;
      _currentText = getBtnText();
    }
    else if (_currentSecond != 0&&haveClicked) {
      _enableButton = false;
      _currentText = widget.showCountdownText
          ? '${getBtnText()}($_currentSecond)'
          : '$_currentSecond';
    } else {
      _enableButton = true;
      _currentText = getBtnText();
    }
  }

  String getBtnText() {
    if (widget.btnText.isEmpty) {
      return tr('send');
    }
    return widget.btnText;
  }
}
