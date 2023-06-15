import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/models/http/data/personal_info_data.dart';
import 'package:base_project/models/http/data/post_info_data.dart';
import 'package:base_project/views/personal/personal_info_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/appbar/custom_app_bar.dart';
import '../../widgets/label/common_network_image.dart';
import '../common_scaffold.dart';

class PersonalHomePage extends ConsumerStatefulWidget {
  const PersonalHomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PersonalHomePageState();
}

class _PersonalHomePageState extends ConsumerState<PersonalHomePage> {
  PersonalInfoData data = PersonalInfoData(
    avatar: GlobalData.photos[0],
    name: 'bbb',
    totalPosts: 15,
    fans: ['qqq', '222', 'ttt'],
    posts: [
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos),
      PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2),
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos),
      PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2),
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos),
      PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2),
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos),
      PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2),
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos),
      PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2),
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos),
      PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2)
    ],
    introduce:
        'texttexttexttexttexttextvtexttexttexttextcontextcontextcontextcontextcontextcontextcontexttexttexttexttexttexttextvtexttexttexttextcontextcontextcontextcontextcontextcontextcontext',
  );

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: Colors.transparent,
        appBar: CustomAppBar.personalAppBar(context, title: 'Rebacca'),
        body: (isDark) => Container(
          width:UIDefine.getWidth(),
          child: Column(
            children: [
              CommonNetworkImage(
                fit: BoxFit.cover,
                imageUrl: data.avatar,
                width: UIDefine.getWidth(),
                height: UIDefine.getViewHeight()*0.6,
              )
            ],
          ),
        ));
  }

}
