import 'package:base_project/constant/enum/border_style_type.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/call_back_function.dart';
import 'package:base_project/widgets/dialog/common_custom_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../widgets/label/image_item_widget.dart';

class GalleryView extends StatefulWidget {
  final PermissionState ps;
  final onGetIntFunction onClickImage;
  const GalleryView({
    Key? key,
    required this.ps,
    required this.onClickImage
  }) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {

  @override
  void initState() {
    _requestAssets();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GalleryView oldWidget) {
    _requestAssets();
    setState(() {

    });
    super.didUpdateWidget(oldWidget);
  }

  final FilterOptionGroup _filterOptionGroup = FilterOptionGroup(
    imageOption: const FilterOption(
      sizeConstraint: SizeConstraint(ignoreSize: true),
    ),
  );
  final int _sizePerPage = 8;

  AssetPathEntity? _path;
  List<AssetEntity>? _entities;
  int _totalEntitiesCount = 0;

  int _page = 0;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMoreToLoad = true;

  Future<void> _requestAssets() async {
    setState(() {
      _isLoading = true;
    });
    // Request permissions.
    if (!mounted) {
      return;
    }
    // Further requests can be only proceed with authorized or limited.
    if (!widget.ps.hasAccess) {
      setState(() {
        _isLoading = false;
      });
      CommonCustomDialog(
        context,
        bOneButton: true,
        type: DialogImageType.fail,
        title: tr('fail'),
        content: 'Permission is not accessible.',
        onRightPress: (){},
        onLeftPress: (){},
      );
      return;
    }
    // Obtain assets using the path entity.
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      onlyAll: true,
      filterOption: _filterOptionGroup,
    );
    if (!mounted) {
      return;
    }
    // Return if not paths found.
    if (paths.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      CommonCustomDialog(
        context,
        bOneButton: true,
        type: DialogImageType.fail,
        title: tr('fail'),
        content: 'No paths found.',
        onRightPress: (){},
        onLeftPress: (){},
      );
      return;
    }
    setState(() {
      _path = paths.first;
    });
    _totalEntitiesCount = await _path!.assetCountAsync;
    final List<AssetEntity> entities = await _path!.getAssetListPaged(
      page: 0,
      size: _sizePerPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _entities = entities;
      _isLoading = false;
      _hasMoreToLoad = _entities!.length < _totalEntitiesCount;
    });
  }

  Future<void> _loadMoreAsset() async {
    final List<AssetEntity> entities = await _path!.getAssetListPaged(
      page: _page + 1,
      size: _sizePerPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _entities!.addAll(entities);
      _page++;
      _hasMoreToLoad = _entities!.length < _totalEntitiesCount;
      _isLoadingMore = false;
    });
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    if (_path == null) {
      return const Center(child: Text('Request paths first.'));
    }
    if (_entities?.isNotEmpty != true) {
      return const Center(child: Text('No assets found on this device.'));
    }
    return GridView.custom(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          if (index == _entities!.length - 8 &&
              !_isLoadingMore &&
              _hasMoreToLoad) {
            _loadMoreAsset();
          }
          final AssetEntity entity = _entities![index];
          return ImageItemWidget(
            key: ValueKey<int>(index),
            entity: entity,
            onTap: (){
              widget.onClickImage(index);
            },
            option: const ThumbnailOption(size: ThumbnailSize.square(200)),
          );
        },
        childCount: _entities!.length,
        findChildIndexCallback: (Key key) {
          // Re-use elements.
          if (key is ValueKey<int>) {
            return key.value;
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: UIDefine.getWidth(),
      //height: UIDefine.getPixelWidth(300),
      child: _buildBody(context)
    );
  }
}
