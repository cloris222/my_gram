import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/views/login/register_choose_gender_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/label/custom_linear_progress.dart';

class registerPreferenceChooseMainPage extends StatefulWidget {
  const registerPreferenceChooseMainPage({Key? key}) : super(key: key);

  @override
  State<registerPreferenceChooseMainPage> createState() => _registerPreferenceChooseMainPageState();
}

class _registerPreferenceChooseMainPageState extends State<registerPreferenceChooseMainPage> {
  BaseViewModel viewModel = BaseViewModel();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: UIDefine.getHeight()*0.1,),
        CustomLinearProgress(
          percentage: 0.3,
          isGradient: true,
          height: UIDefine.getPixelWidth(3),
        ),
        SizedBox(height: UIDefine.getHeight()*0.01,),
        Row(
          children: [
            Expanded(child: TextButton(
              child: Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: (){
                viewModel.popPage(context);
              },
            ),),
            SizedBox(width: UIDefine.getWidth()*0.9,)
          ],
        ),
        SizedBox(height: UIDefine.getHeight()*0.05,),
        RegisterChooseGenderPage(),
      ],
    );
  }
}




