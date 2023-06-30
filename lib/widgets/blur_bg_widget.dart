import 'package:flutter/cupertino.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import '../constant/theme/app_colors.dart';
import '../constant/theme/ui_define.dart';

class BlurBgWidget extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final double? blur;
  final LinearGradient? linearGradient;
  const BlurBgWidget({
    this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.blur,
    this.linearGradient,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: AppColors.dynamicButtonsBorder.getColor().withOpacity(0.1),
          borderRadius: borderRadius??BorderRadius.circular(UIDefine.getPixelWidth(40))
      ),
      child: GlassContainer(
        width: width??UIDefine.getWidth()* 0.85,
        height: height,
        border: 0.0,
        blur: blur??10,
        linearGradient: linearGradient??LinearGradient(
            colors: [ AppColors.dynamicButtons.getColor().withOpacity(0.2),AppColors.dynamicButtons.getColor().withOpacity(0.2)]
        ),
        borderRadius:borderRadius??BorderRadius.circular(UIDefine.getPixelWidth(40)),
        child: child
      ),
    );
  }
}
