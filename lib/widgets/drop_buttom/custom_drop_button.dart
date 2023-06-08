import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/theme/app_text_style.dart';
import '../../constant/theme/ui_define.dart';


class CustomDropButton extends StatefulWidget {
  const CustomDropButton(
      {Key? key,
        required this.listLength,
        required this.itemString,
        this.itemIcon,
        required this.onChanged,
        this.initIndex,
        this.needBorderBackground = true,
        this.height,
        this.buildCustomDropItem,
        this.buildCustomSelectHintItem,
        this.buildCustomDropCurrentItem,
        this.padding,
        this.hintSelect,
        this.dropdownWidth,
        this.needShowEmpty = true, this. needArrow=true,this.textColor,this.selectTextColor,this.offsetX,this.offsetY})
      : super(key: key);
  final int listLength;
  final int? initIndex;
  final Widget Function(int index, bool needGradientText, bool needArrow)?
  buildCustomDropItem;
  final Widget Function(int? currentIndex)? buildCustomDropCurrentItem;
  final String Function(int index, bool needArrow) itemString;
  final Widget Function(int index)? itemIcon;
  final void Function(int index) onChanged;
  final double? height;
  final bool needBorderBackground;
  final EdgeInsetsGeometry? padding;
  final String? hintSelect;
  final double? dropdownWidth;
  final Widget Function()? buildCustomSelectHintItem;
  final bool needShowEmpty;
  final bool needArrow;
  final AppColors? textColor;
  final AppColors? selectTextColor;
  final double? offsetX;
  final double? offsetY;

  @override
  State<CustomDropButton> createState() => _CustomDropButtonState();
}

class _CustomDropButtonState extends State<CustomDropButton> {
  int? currentIndex;

  @override
  void initState() {
    currentIndex = widget.initIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _dropDownBar();
  }

  Widget _dropDownBar() {
    return Container(
      decoration: widget.needBorderBackground
          ? AppStyle().styleColorBorderBackground(
          color: AppColors.bolderGrey.getColor(),
          backgroundColor: AppColors.textFieldBackground.getColor(),
          radius: 8,
          borderLine: 1)
          : null,
      alignment: Alignment.centerLeft,
      child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            offset: Offset(widget.offsetX??0, widget.offsetX??-UIDefine.getPixelWidth(10)),
            dropdownDecoration: AppStyle().styleColorBorderBackground(
                color: AppColors.textFieldBackground.getColor(),
                backgroundColor: AppColors.textFieldBackground.getColor(),
                radius: 0,
                borderLine: 1),
            customButton: widget.buildCustomDropCurrentItem != null
                ? widget.buildCustomDropCurrentItem!(currentIndex)
                : currentIndex != null
                ? _buildDropItem(currentIndex!, false, true)
                : _buildSelectHintItem(),
            isExpanded: true,
            items: List<DropdownMenuItem<int>>.generate(_getListLength(), (index) {
              return DropdownMenuItem<int>(
                  enabled: !(widget.listLength == 0 && widget.needShowEmpty),
                  value: index,
                  child: _buildDropItem(index, true, false));
            }),
            value: widget.listLength == 0 ? null : currentIndex,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  currentIndex = value;
                });
                widget.onChanged(currentIndex!);
              }
            },
            dropdownWidth: widget.dropdownWidth,
            itemHeight: UIDefine.getPixelWidth(40),

          )),
    );
  }

  Widget _buildSelectHintItem() {
    if (widget.buildCustomSelectHintItem != null) {
      return widget.buildCustomSelectHintItem!();
    }

    return _buildItem(
        context: widget.hintSelect ?? tr('hintSelect'),
        index: -1,
        needGradientText: false,
        needArrow: true);
  }

  Widget _buildDropItem(int index, bool needGradientText, bool needArrow) {
    if (widget.listLength == 0 && widget.needShowEmpty) {
      return _buildItem(
          context: tr('ES_0007'),
          index: index,
          needGradientText: needGradientText,
          needArrow: needArrow);
    }

    if (widget.buildCustomDropItem != null) {
      return widget.buildCustomDropItem!(index, needGradientText, needArrow);
    }

    return _buildItem(
        index: index, needGradientText: needGradientText, needArrow: needArrow);
  }

  Widget _buildItem(
      {String? context,
        required int index,
        required bool needGradientText,
        required bool needArrow}) {
    bool isCurrent = (currentIndex == index);
    String itemContext = '';
    if (context != null) {
      isCurrent = false;
      itemContext = context;
    } else {
      itemContext = _getItemString(index, needArrow);
    }

    return Container(
      alignment: Alignment.centerLeft,
      height: widget.height ?? UIDefine.getPixelWidth(40),
      padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(8)),
      // color: AppColors.textFieldBackground,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.itemIcon != null && index >= 0
              ? Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: UIDefine.getPixelWidth(5)),
              child: widget.itemIcon!(index))
              : const SizedBox(),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: isCurrent && needGradientText
                  ? Text(
                itemContext,
                maxLines: needArrow ? 1 : null,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.getBaseStyle(
                    fontSize: UIDefine.fontSize14,
                    color: (widget.selectTextColor??AppColors.mainThemeButton)),
              )
                  : Text(
                itemContext,
                maxLines: needArrow ? 1 : null,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.getBaseStyle(
                    color:widget.textColor??AppColors.textPrimary,
                    fontSize: UIDefine.fontSize14),
              ),
            ),
          ),
          Visibility(
              visible: needArrow&&widget.needArrow,
              child: const Icon(Icons.arrow_drop_down,color: Colors.grey,))
        ],
      ),
    );
  }

  String _getItemString(int index, bool needArrow) {
    if (widget.listLength == 0) {
      return widget.hintSelect ?? tr('hintSelect');
    }
    return widget.itemString(index, needArrow);
  }

  int _getListLength() {
    return widget.listLength > 0
        ? widget.listLength
        : widget.needShowEmpty
        ? 1
        : 0;
  }
}
