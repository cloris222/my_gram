import 'package:base_project/constant/theme/ui_define.dart';
import 'package:flutter/material.dart';

import 'common_network_image.dart';

class AvatarIconWidget extends StatelessWidget {
  const AvatarIconWidget(
      {Key? key, required this.imageUrl, this.size, this.changeWidth})
      : super(key: key);
  final String imageUrl;
  final double? size;
  final int? changeWidth;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CommonNetworkImage(
        imageUrl: imageUrl,
        width: size ?? UIDefine.getPixelWidth(40),
        height: size ?? UIDefine.getPixelWidth(40),
        cacheWidth: changeWidth ?? 40,
        fit: BoxFit.cover,
      ),
    );
  }
}
