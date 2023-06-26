import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../constant/theme/app_colors.dart';

///MARK: 漸進式讀取圖片
class CommonNetworkImage extends StatelessWidget {
  const CommonNetworkImage(
      {Key? key,
      required this.imageUrl,
      this.cacheWidth,
      this.width,
      this.height,
      this.fit,
      this.errorWidget,
      this.loadWidget,
      this.child,
      this.childAlignment,
      this.childPadding,
      this.imageWidgetBuilder,
      this.radius = 8,
      this.background = Colors.black,
      })
      : super(key: key);
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Widget? loadWidget;
  final int? cacheWidth;
  final double radius;
  final Color background;

  /// Optional builder to further customize the display of the image.
  /// 供Container背景用
  final Widget? child;
  final AlignmentGeometry? childAlignment;
  final EdgeInsetsGeometry? childPadding;

  ///MARK: 與child只能擇一使用
  final ImageWidgetBuilder? imageWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    return _buildLoadPath();
  }

  Widget _buildLoadingIcon() {
    return Center(
        child: loadWidget ??
            LoadingAnimationWidget.hexagonDots(
                color: AppColors.textPrimary.getColor(), size: 20));
  }

  Widget _buildErrorIcon() {
    return Center(child: errorWidget ?? const Icon(Icons.cancel_rounded));
  }

  Widget _buildLoadPath() {
    /// 判斷是否為assets 路徑的圖片
    if (imageUrl.contains("assets/")) {
      return _buildAssetImage();
    }
    // String lowUrl;
    // if (imageUrl.contains('.')) {
    //   int index = imageUrl.lastIndexOf('.');
    //   lowUrl =
    //       '${imageUrl.substring(0, index)}_compre${imageUrl.substring(index)}';
    // } else {
    //   lowUrl = imageUrl;
    // }

    return Container(
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: fit,
        imageUrl: imageUrl,
        memCacheWidth: cacheWidth ?? 480,
        cacheManager: CacheManager(
          Config("flutterCampus", stalePeriod: const Duration(minutes: 5)),
        ),
        imageBuilder: _buildImageBuilder(),
        placeholder: (context, url) => _buildLoadingIcon(),
        errorWidget: (context, url, error) => _buildErrorIcon(),
      ),
    );
  }

  ImageWidgetBuilder? _buildImageBuilder() {
    return child != null
        ? (context, imageProvider) => Container(
            alignment: childAlignment,
            padding: childPadding,
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: fit),
            ),
            child: child)
        : imageWidgetBuilder;
  }

  /// 增加判斷是否為Asset 圖片
  Widget _buildAssetImage() {
    if (child != null) {
      return Container(
        color: Colors.black,
        width: width,
        height: height,
        child: Container(
            alignment: childAlignment,
            padding: childPadding,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      width: width,
                      height: height,
                      fit: fit,
                      image: AssetImage(imageUrl),
                    ).image,
                    fit: fit),
                borderRadius: BorderRadius.all(Radius.circular(radius)))),
      );
    }
    return Container(
      alignment: childAlignment,
      padding: childPadding,
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        fit: fit,
        image: AssetImage(
          imageUrl,
        ),
      ),
    );
  }
}
