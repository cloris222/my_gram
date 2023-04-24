import 'package:base_project/constant/enum/pair_enum.dart';
import 'package:flutter/material.dart';
import '../../models/parameter/pair_image_data.dart';
import 'swipe_image_view.dart';

class PairMainPage extends StatefulWidget {
  const PairMainPage({Key? key}) : super(key: key);

  @override
  State<PairMainPage> createState() => _PairMainPageState();
}

class _PairMainPageState extends State<PairMainPage> {
  final List<String> photos = [
    "https://images.unsplash.com/photo-1586164383881-d01525b539d6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    "https://images.unsplash.com/photo-1594367031514-3aee0295ec98?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80",
    "https://images.unsplash.com/photo-1618759287629-ca56b5916066?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
  ];
  final List<String> addPhotos = [
    "https://images.unsplash.com/photo-1536589961747-e239b2abbec2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    "https://images.unsplash.com/photo-1577980906127-4ea7faa2c6f0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80",
    "https://images.unsplash.com/photo-1623411963493-e958d623cee0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
  ];
  final List<PairImageData> list = [];

  @override
  void initState() {
    list.add(PairImageData(
        images: photos, name: "cat1", context: "catcatcatcatcatcat"));
    list.add(PairImageData(
        images: addPhotos, name: "cat2", context: "cutecutecutecutecutecute"));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: List.generate(
            list.length,
            (index) => SwipeImageView(
                  key: UniqueKey(),
                  data: list[index],
                  onRemove: _onRemove,
                )));
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
