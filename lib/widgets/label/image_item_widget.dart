import 'package:base_project/view_models/call_back_function.dart';
import 'package:base_project/view_models/message/chat_room_provider.dart';
import 'package:base_project/widgets/label/select_number_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageItemWidget extends ConsumerStatefulWidget {
  const ImageItemWidget({
    Key? key,
    required this.entity,
    required this.option,
    required this.onTap,
  }) : super(key: key);

  final AssetEntity entity;
  final ThumbnailOption option;
  final  onClickFunction onTap;

  @override
  ConsumerState createState() => _ImageItemWidgetState();
}

class _ImageItemWidgetState extends ConsumerState<ImageItemWidget> {
  List<AssetEntity> get imageList => ref.read(chatRoomProvider).imageList;
  bool beSelect = false;
  Widget buildContent(BuildContext context) {
    if (widget.entity.type == AssetType.audio) {
      return const Center(
        child: Icon(Icons.audiotrack, size: 30),
      );
    }
    return _buildImageWidget(context, widget.entity, widget.option);
  }

  Widget _buildImageWidget(
      BuildContext context,
      AssetEntity entity,
      ThumbnailOption option,
      ) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: AssetEntityImage(
            entity,
            isOriginal: false,
            thumbnailSize: option.size,
            thumbnailFormat: option.format,
            fit: BoxFit.cover,
          ),
        ),
        PositionedDirectional(
          top: 4,
          start: 0,
          end: 2 ,
          child: Row(
            children: [
              if (entity.isFavorite)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                    size: 16,
                  ),
                ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _getNumber(entity)>0?
                    SelectNumberIcon(number:_getNumber(entity)):
                    Icon(
                      Icons.radio_button_unchecked,
                      color: Colors.white,
                      size: 25,
                    ),
                    // if (entity.isLivePhoto)
                    //   Container(
                    //     margin: const EdgeInsetsDirectional.only(end: 4),
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 3,
                    //       vertical: 1,
                    //     ),
                    //     decoration: BoxDecoration(
                    //       borderRadius: const BorderRadius.all(
                    //         Radius.circular(4),
                    //       ),
                    //       color: Theme.of(context).cardColor,
                    //     ),
                    //     child: const Text(
                    //       'LIVE',
                    //       style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 10,
                    //         fontWeight: FontWeight.bold,
                    //         height: 1,
                    //       ),
                    //     ),
                    //   ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(chatRoomProvider);
    return GestureDetector(
      onTap: (){
        _onTap();},
      child: buildContent(context),
    );
  }
  _onTap(){
    widget.onTap();
    setState((){
      _getNumber(widget.entity);
    });
  }

  int _getNumber(AssetEntity entity){
    int number = imageList.indexWhere((el) => entity.id == el.id);
    return number+1;
  }
}
