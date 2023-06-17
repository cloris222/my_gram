import 'package:flutter/cupertino.dart';

import '../constant/theme/ui_define.dart';
import 'label/common_network_image.dart';

class CircleAvatarWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  const CircleAvatarWidget({
    required this.imageUrl,
    this.width,
    this.height,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width??UIDefine.getPixelWidth(40),
      height: height??UIDefine.getPixelWidth(40),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50)
      ),
      child: CommonNetworkImage(
        imageUrl: imageUrl,
        width: width??UIDefine.getPixelWidth(40),
        height: height??UIDefine.getPixelWidth(40),
        fit: BoxFit.cover,
      ),
    );
  }
}
