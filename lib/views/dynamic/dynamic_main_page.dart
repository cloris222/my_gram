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
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/global_data.dart';
import '../../models/http/data/store_info_data.dart';
import '../../utils/observer_pattern/dynamic/dynamic_observer.dart';
import '../../view_models/dynmaic/is_rebecca_provider.dart';
import '../../widgets/dialog/common_custom_dialog.dart';
import 'dynamic_info_view.dart';
import 'dynamic_post_comment_page.dart';

class DynamicMainPage extends ConsumerStatefulWidget {
  const DynamicMainPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _DynamicMainPageState();
}

class _DynamicMainPageState extends ConsumerState<DynamicMainPage> {
  List<DynamicInfoData> list = [];
  List<DynamicInfoData> isRebeccaList = GlobalData.generateIsRebeccaData(8);
  List<DynamicInfoData> notRebeccaList = GlobalData.generateNotRebeccaData(8);
  int clickLikeTimes = 1;
  bool bDownloading = true;
  BaseViewModel viewModel = BaseViewModel();
  List<StoreInfoData> stores = GlobalData.generateStoreData(10);
  TextEditingController controller = TextEditingController();

  bool get isRebecca => ref.read(isRebeccaProvider);
  late ScrollController scrollController;

  late DynamicObserver observer;

  @override
  void initState() {
    scrollController = ScrollController(
        initialScrollOffset: isRebecca ? GlobalData.dynamicRebeccaOffset : GlobalData.dynamicOffset);
    scrollController.addListener(_setScrollerListener);
    // Future.delayed(Duration.zero,(){
    //   setState(() {
    //     if(isRebecca == true){
    //       list.addAll(isRebeccaList);
    //     }else{
    //       list.addAll(notRebeccaList);
    //     }
    //   });
    // });
    /// 暫時先直接加入

    if (isRebecca == true) {
      list.addAll(isRebeccaList);
    } else {
      list.addAll(notRebeccaList);
    }
    observer = DynamicObserver("AA",
        scrollTop: () => scrollController.animateTo(0,
            duration: Duration(milliseconds: 200),
            curve: Curves.fastLinearToSlowEaseIn));
    GlobalData.dynamicSubject.registerObserver(observer);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_setScrollerListener);
    scrollController.dispose();
    GlobalData.dynamicSubject.clearObserver();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(isRebeccaProvider,( previous,  next){
      setState(() {
        if (next == true) {
          list = isRebeccaList;
        } else {
          list = notRebeccaList ;
        }
      });
    });
   return CommonScaffold(
       body: (isDark) => Container(
         decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImagePath.gradientBg),fit: BoxFit.fill)
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
                     // _updateView();
                   }
                 }
               }
               return true;
             },
             child: CustomScrollView(
               scrollDirection: Axis.vertical,
               controller: scrollController,
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
                       decoration: const BoxDecoration(
                         borderRadius: BorderRadius.vertical(
                           bottom: Radius.circular(10)
                         ),
                           image: DecorationImage(image: AssetImage(AppImagePath.gradientBg),fit: BoxFit.fill)
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
                           width: UIDefine.getPixelWidth(40),
                           height: UIDefine.getPixelWidth(40),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(50),
                             color: AppColors.buttonCommon.getColor().withOpacity(0.5)
                           ),
                           child: Container(
                            alignment: Alignment.center,
                             width: UIDefine.getPixelWidth(15),
                               height: UIDefine.getPixelWidth(17),
                               child: Image.asset(AppImagePath.shopIcon,fit: BoxFit.fill,)),
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
                       padding: EdgeInsets.only(bottom: UIDefine.getNavigationBarHeight()),
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



  void _setScrollerListener() {
    if (!isRebecca) {
      GlobalData.dynamicOffset = scrollController.offset;
    }
  }
}
