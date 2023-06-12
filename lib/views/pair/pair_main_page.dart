import 'package:base_project/constant/enum/pair_enum.dart';
import 'package:base_project/constant/theme/global_data.dart';
import 'package:flutter/material.dart';
import '../../constant/theme/ui_define.dart';
import '../../models/http/data/pair_image_data.dart';
import 'swipe_image_view.dart';

class PairMainPage extends StatefulWidget {
  const PairMainPage({Key? key}) : super(key: key);

  @override
  State<PairMainPage> createState() => _PairMainPageState();
}

class _PairMainPageState extends State<PairMainPage> {
  final List<PairImageData> list = [];

  @override
  void initState() {
    list.add(PairImageData(
        images: GlobalData.photos,
        name: "cat1",
        context: "catcatcatcatcatcat"));
    list.add(PairImageData(
        images: GlobalData.photos2,
        name: "cat2",
        context: "cutecutecutecutecutecute"));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = List.generate(
        list.length,
        (index) => SwipeImageView(
              key: UniqueKey(),
              data: list[index],
              onRemove: _onRemove,
            ));
    /// MARK: 加入避免重複觸碰
    if (widgetList.isNotEmpty) {
      widgetList.insert(
          widgetList.length - 1,
          Container(
              color: Colors.transparent,
              width: UIDefine.getWidth(),
              height: UIDefine.getViewHeight()));
    }
    return Stack(children: widgetList);
  }

  void _onRemove(PairImageData data, GramSetStatus status) {
    setState(() {
      if (status == GramSetStatus.like) {
      } else {}
      list.removeLast();

      /// MARK: 移除後，新增一筆到底部
      // if (addPhotos.isNotEmpty) {
      //   list.insert(0, PairImageData(images: addPhotos.removeLast()));
      // }
    });
  }
}
