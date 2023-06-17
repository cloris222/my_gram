import 'package:base_project/constant/enum/border_style_type.dart';
import 'package:base_project/constant/theme/app_colors.dart';
import 'package:base_project/constant/theme/app_image_path.dart';
import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/models/http/data/dynamic_info_data.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/views/common_scaffold.dart';
import 'package:base_project/widgets/label/common_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constant/theme/global_data.dart';
import '../../models/http/data/store_info_data.dart';
import '../../widgets/dialog/common_custom_dialog.dart';
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
  List<StoreInfoData> stores = GlobalData.generateStoreData(10);
  TextEditingController controller = TextEditingController();


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
   return CommonScaffold(
       body: (isDark) => Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
             colors: [AppColors.personalDarkBackground.getColor(),AppColors.personalLightBackground.getColor()]
           )
         ),
         child: NotificationListener<ScrollEndNotification>(
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
             child: CustomScrollView(
               slivers: [
                 SliverAppBar(
                   automaticallyImplyLeading: false,
                   snap: false,
                   floating: true,
                   pinned: false,
                   expandedHeight: UIDefine.getPixelWidth(60),
                   backgroundColor: Colors.transparent,
                   flexibleSpace: FlexibleSpaceBar(
                     background: Container(
                       decoration: BoxDecoration(
                         borderRadius: const BorderRadius.vertical(
                           bottom: Radius.circular(10)
                         ),
                         gradient: LinearGradient(
                           colors: [AppColors.personalDarkBackground.getColor(),AppColors.personalLightBackground.getColor()], // 渐变颜色列表
                         ),
                       ),
                     ),
                   ),
                   title: Container(
                     width: UIDefine.getWidth(),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Image.asset(AppImagePath.logoTextImage),
                         Container(
                           width: UIDefine.getPixelWidth(35),
                           height: UIDefine.getPixelWidth(35),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(50),
                             color: AppColors.buttonCommon.getColor().withOpacity(0.5)
                           ),
                           child: Image.asset(AppImagePath.shopIcon),
                         )
                       ],
                     ),
                   ),
                 ),
                 SliverToBoxAdapter(
                   child: ListView.builder(
                       shrinkWrap: true,
                       physics: const NeverScrollableScrollPhysics(),
                       itemCount: list.length,
                       padding: EdgeInsets.zero,
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
                             _showCustomModalBottomSheet(context,stores);
                           },
                           onShare: (index){
                             _onShare().then((value) => setState((){}));
                           },
                           showFullContext: (index){
                             _showMore(index);
                           },
                           showLessContext: (index){
                             _showLess(index);
                           },
                         );
                       }),
                 )
               ],
             )),
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


  void _onFollowing(int index){
    setState(() {
      list[index].isFollowing = !list[index].isFollowing;
    });
  }

   void _showMore(int index){
    setState(() {
      list[index].isShowMore = true;
    });
  }

  void _showLess(int index){
    setState(() {
      list[index].isShowMore = false;
    });
  }

  Future<void> _onShare()async{
    await CommonCustomDialog(context,
        type: DialogImageType.success,
        title: tr("Success"),
        content: tr('bscText'),
        rightBtnText: tr('confirm'),
        onLeftPress: () {}, onRightPress: () {
          Navigator.pop(context);
        }).show();
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

  _showCustomModalBottomSheet(context, List<StoreInfoData> stores) async {
    return showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:(BuildContext context, StateSetter setState)=> Container(
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
                color: AppColors.dialogBackground.getColor(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                   Icon(Icons.bookmark,color: AppColors.textPrimary.getColor(),),
                    Text(tr('chooseStorePlace'),style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize16,
                        color: AppColors.textPrimary
                    ),),
                    GestureDetector(
                      onTap: (){
                        // Navigator.of(context).pop();
                        _addStore(context).then((value) => setState((){}));
                      },
                      child: Text(tr('add'),style: AppTextStyle.getBaseStyle(
                          fontSize: UIDefine.fontSize16,
                          color: AppColors.textPrimary),),
                    )
                  ],
                ),
              ),
              Divider(height: 1.0),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(UIDefine.getPixelWidth(10)),
                      width: UIDefine.getWidth()*0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                child: CommonNetworkImage(
                                  width: UIDefine.getPixelWidth(60),
                                  height: UIDefine.getPixelWidth(60),
                                  imageUrl: stores[index].avatar,
                                ),
                              ),
                              SizedBox(width: UIDefine.getPixelWidth(5),),
                              Text(stores[index].name,style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16),)
                            ],
                          ),
                          GestureDetector(
                            onTap: (){

                            },
                            child: Icon(Icons.add,color: AppColors.textPrimary.getColor(),),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: stores.length,
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
  
  Future<void>_addStore(BuildContext context)async{
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(15.0)), //this right here
            child:
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Color(0xff333333),
                borderRadius: BorderRadius.circular(15.0),
              ),
              width: UIDefine.getPixelWidth(300),
              height: UIDefine.getPixelWidth(120),
              child: Column(children: [
                Container(
                  height: 50,
                  color: AppColors.dialogBackground.getColor(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: (){
                          controller.text = '';
                          Navigator.of(context).pop();
                        },
                        child: Text(tr('cancel')),
                      ),
                      Text(tr('addStorePlace'),style: AppTextStyle.getBaseStyle(
                          fontSize: UIDefine.fontSize16,
                          color: AppColors.textPrimary
                      ),),
                      GestureDetector(
                        onTap: (){
                          if(controller.text == '')return;
                          stores.add(
                              StoreInfoData(
                                name:controller.text,
                                avatar: GlobalData.photos[0],
                                list: []
                              )
                          );
                          controller.text = '';
                          Navigator.of(context).pop();
                          setState(() {

                          });
                        },
                        child: Text(tr('save'),style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize16,
                            color: AppColors.textPrimary),),
                      )
                    ],
                  ),
                ),
                SizedBox(height: UIDefine.getPixelWidth(5),),
                Container(
                  width: UIDefine.getPixelWidth(200),
                  height: UIDefine.getPixelWidth(40),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        fillColor: Color(0xff1F1F1F),
                        hintText: tr('inputStoreName')
                    ),
                  )
                )
              ]),
            )
          );
        });
  }


}
