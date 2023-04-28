import 'package:base_project/view_models/base_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/ui_define.dart';
import '../../widgets/button/text_button_widget.dart';
import '../../widgets/label/custom_linear_progress.dart';
import '../main_screen.dart';

class registerFinishPage extends StatelessWidget {
  final BaseViewModel viewModel = BaseViewModel();
  registerFinishPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: UIDefine.getHeight()*0.1,),
              Container(
                width: UIDefine.getWidth()*0.9,
                child: Center(
                  child: CustomLinearProgress(
                    percentage: 1,
                    isGradient: true,
                    height: UIDefine.getPixelWidth(3),
                  ),
                ),
              ),
              SizedBox(height: UIDefine.getHeight()*0.01,),
              Row(
                children: [
                  Expanded(child: TextButton(
                    child: Icon(Icons.chevron_left,color: Colors.white,size: UIDefine.getPixelWidth(35),),
                    onPressed: (){
                      viewModel.popPage(context);
                    },
                  ),),
                  SizedBox(width: UIDefine.getWidth()*0.9,)
                ],
              ),
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 3)),
                width: UIDefine.getPixelWidth(250),
                height: UIDefine.getPixelWidth(200),
                child:Image.asset(AppImagePath.demoImage),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButtonWidget(
                    fontSize: UIDefine.fontSize18,
                    radius: 50,
                    setMainColor: Colors.white,
                    textColor:AppColors.textBlack,
                    isFillWidth: false,
                    backgroundVertical: UIDefine.getPixelWidth(8),
                    setHeight: UIDefine.getPixelWidth(44),
                    setWidth: UIDefine.getWidth()*0.75,
                    btnText: tr('finishRegisterBobbleText'),
                    onPressed:(){

                    } ,
                  ),
                ],),
              SizedBox(height: UIDefine.getHeight()*0.1,),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButtonWidget(
                        fontSize: UIDefine.fontSize18,
                        radius: 4,
                        isGradient: true,
                        textColor:AppColors.textBlack,
                        isFillWidth: false,
                        backgroundVertical: UIDefine.getPixelWidth(8),
                        setHeight: UIDefine.getPixelWidth(44),
                        setWidth: UIDefine.getWidth()*0.4,
                        btnText: tr('use'),
                        onPressed:(){
                          viewModel.pushPage(context, const MainScreen());
                        } ,
                      ),
                    ],),
                  SizedBox(height: UIDefine.getPixelWidth(20),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButtonWidget(
                        fontSize: UIDefine.fontSize18,
                        radius: 4,
                        isGradient: true,
                        textColor:AppColors.textBlack,
                        isFillWidth: false,
                        backgroundVertical: UIDefine.getPixelWidth(8),
                        setHeight: UIDefine.getPixelWidth(44),
                        setWidth: UIDefine.getWidth()*0.4,
                        btnText: tr('createPersonal'),
                        onPressed:(){
                          viewModel.pushPage(context, const MainScreen());
                        } ,
                      ),
                    ],)
                ],
              )

            ],
          ),
        )
    );
  }
}
