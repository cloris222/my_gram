import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/models/data/personal_info_data.dart';
import 'package:base_project/models/data/post_info_data.dart';
import 'package:base_project/views/personal/personal_info_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/appbar/custom_app_bar.dart';
import '../common_appbar_view.dart';

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
    name:'bbb',
    totalPosts: 15,
    fans: ['qqq','222','ttt'],
    posts: [
      PostInfoData(
        context: 'contextcontextcontextcontextcontextcontextcontext',
        images: GlobalData.photos
    ),PostInfoData(
        context: 'texttexttexttexttexttextvtexttexttexttext',
        images: GlobalData.photos2
    ),
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos
      ),PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2
      ),
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos
      ),PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2
      ),
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos
      ),PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2
      ),
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos
      ),PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2
      ),
      PostInfoData(
          context: 'contextcontextcontextcontextcontextcontextcontext',
          images: GlobalData.photos
      ),PostInfoData(
          context: 'texttexttexttexttexttextvtexttexttexttext',
          images: GlobalData.photos2
      )
    ],
    introduce: 'texttexttexttexttexttextvtexttexttexttextcontextcontextcontextcontextcontextcontextcontexttexttexttexttexttexttextvtexttexttexttextcontextcontextcontextcontextcontextcontextcontext',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.titleAppBar(context, title: 'personalHomePage'),
      body: Container(
        color: Colors.black,
        child: PersonalInfoView(
        data: data,
        clickFollowing: _clickFollowing,
        clickMessage: _clickMessage,
          clickSeeMore: _clickSeeMore,
      ),)

    );

  }

  _clickFollowing(){
    setState(() {
      data.isFollowing = !data.isFollowing;
    });
  }

  _clickMessage(){
    print('clickMessage');
  }

  _clickSeeMore(){
    setState(() {
      data.isShowMore = true;
      print(data.isShowMore);
    });
  }
}
