import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_style.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/models/data/dynamic_info_data.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/theme/global_data.dart';
import '../../widgets/label/custom_gradient_icon.dart';
import 'dynamic_info_view.dart';
import 'dynamic_post_comment_page.dart';

class DynamicMainPage extends StatefulWidget {
  const DynamicMainPage({Key? key}) : super(key: key);

  @override
  State<DynamicMainPage> createState() => _DynamicMainPageState();
}

class _DynamicMainPageState extends State<DynamicMainPage> {
  final List<DynamicInfoData> list = [];
  int clickLikeTimes = 1;
  bool bDownloading = true;
  BaseViewModel viewModel = BaseViewModel();
  List<String> options = ['2','4','6','3','9','5'];


  @override
  void initState() {
    list.add(DynamicInfoData(
        avatar: GlobalData.photos[0],
        name: 'name',
        time: '2023-05-02 12:00',
        context: 'contextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontext'
            'contextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontext',
        images: GlobalData.photos2,
        likes: 1000,
        comments: 20000));
    list.add(DynamicInfoData(
        avatar: GlobalData.photos[1],
        name: 'name222',
        time: '2023-04-01',
        context: 'contextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontext'
            'contextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontext',
        images: GlobalData.photos2,
        likes: 30000,
        comments: 400));
    list.add(DynamicInfoData(
        avatar: GlobalData.photos[2],
        name: 'name333',
        time: '2023-04-30',
        context: 'contextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontext'
            'contextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontext',
        images: GlobalData.photos2,
        likes: 500,
        comments: 20000));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return NotificationListener<ScrollEndNotification>(
     onNotification: (scrollEnd){
       final metrics = scrollEnd.metrics;
       if (metrics.atEdge) {
         bool isTop = metrics.pixels == 0;
         if (isTop) {
           GlobalData.printLog('At the top');
         } else {
           GlobalData.printLog('At the bottom');
           if (!bDownloading) {
             // 防止短時間載入過多造成OOM
             bDownloading = true;
             _updateView();
           }
         }
       }
       return true;
     },
       child: SingleChildScrollView(
           child: Container(
             width: UIDefine.getWidth(),
             child: ListView.builder(
                 shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(),
                 itemCount: list.length,
                 itemBuilder: (context,index){
                   if(index == list.length-1){
                     bDownloading = false;
                   }
                   return DynamicInfoView(
                     data: list[index],
                     index:index,
                     onComment: (index){
                       _onComment(index);
                     },
                     onFollowing: (index){
                       _onFollowing(index);
                     },
                     onLike: (index){
                       _onlike(index);
                     },
                     onStore: (index){
                       _showCustomModalBottomSheet(context,options);
                     },
                     showFullContext: (index){
                       _showMore(index);
                     },
                   );
                 })
           )
       ));
  }

  _onComment(int index){
    viewModel.pushPage(context, DynamicPostCommentPage(postId: '123',));
  }

  _onlike(int index) {
    setState(() {
      int likesCount = list[index].likes;
      if (clickLikeTimes % 2 != 0) {
        likesCount++;
        clickLikeTimes++;
      } else {
        likesCount--;
        clickLikeTimes++;
      }
      list[index].likes = likesCount;
    });
  }


  _onFollowing(int index){
    setState(() {
      list[index].isFollowing = !list[index].isFollowing;
    });
  }

   _showMore(int index){
    setState(() {
      list[index].isShowMore = true;
    });
  }

  _updateView(){
    setState(() {
      list.addAll([
        DynamicInfoData(
            avatar: GlobalData.photos[0],
            name: 'name555',
            time: '2023-05-02 13:00',
            context: 'contextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontext'
                'contextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontext',
            images: GlobalData.photos2,
            likes: 1000,
            comments: 20000),
        DynamicInfoData(
            avatar: GlobalData.photos[1],
            name: 'name666',
            time: '2023-04-02 12:00',
            context: 'contextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontext'
                'contextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontext',
            images: GlobalData.photos2,
            likes: 1000,
            comments: 20000),
        DynamicInfoData(
            avatar: GlobalData.photos[2],
            name: 'name777',
            time: '2023-01-02 12:00',
            context: 'contextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontext'
                'contextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontextcontext',
            images: GlobalData.photos2,
            likes: 1000,
            comments: 20000),
      ]);
    });
  }

  _showCustomModalBottomSheet(context, List<String> options) async {
    return showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0),
            ),
          ),
          height: UIDefine.getHeight()*0.4,
          child: Column(children: [
            Container(
              height: 50,
              color: Color(0xff333333),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                 Icon(Icons.bookmark,color: AppColors.textWhite,),
                  Text(tr('chooseStorePlace'),style: AppTextStyle.getBaseStyle(
                    fontSize: UIDefine.fontSize16,
                      color: AppColors.textWhite
                  ),),
                  GestureDetector(
                    onTap: (){},
                    child: Text(tr('add'),style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize16,
                        color: AppColors.textWhite),),
                  )
                ],
              ),
            ),
            Divider(height: 1.0),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(options[index]),
                      onTap: () {
                        Navigator.of(context).pop(index);
                      });
                },
                itemCount: options.length,
              ),
            ),
          ]),
        );
      },
    );
  }


}
