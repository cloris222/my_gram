import 'package:base_project/constant/theme/ui_define.dart';
import 'package:flutter/cupertino.dart';

import '../../constant/theme/global_data.dart';
import '../../models/data/personal_info_data.dart';

class PersonalInfoView extends StatefulWidget {
  final PersonalInfoData data;

  const PersonalInfoView({
    required this.data,
    Key? key}) : super(key: key);

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  bool bDownloading = true;
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
        onNotification: (scrollEnd) {
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
    child: SingleChildScrollView(
      child: Column(
        children: [
          ///上方info navbar
          Container(
            width: UIDefine.getWidth(),
            child: Row(
              children: [
                Container(
                  child: Text('123'),
                  // child: GraduallyNetworkImage(
                  //   width: double.infinity,
                  //   height: UIDefine.getScreenWidth(50),
                  //   cacheWidth: 1440,
                  //   imageUrl: data.introPhoneUrl,
                  //   fit: BoxFit.cover,
                  // ),
                )
              ],
            ),
          )
        ],
      ),
    ),);
  }
}
