import 'package:base_project/constant/theme/app_text_style.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:base_project/view_models/gobal_provider/global_tag_controller_provider.dart';
import 'package:base_project/widgets/label/login_param_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/demo_type_view_model.dart';
import '../widgets/button/text_button_widget.dart';

class DemoTypeView extends ConsumerStatefulWidget {
  const DemoTypeView({Key? key, required this.typeName}) : super(key: key);
  final String typeName;

  @override
  ConsumerState createState() => _DemoTypeViewState();
}

class _DemoTypeViewState extends ConsumerState<DemoTypeView> {
  late DemoTypeViewModel viewModel;

  @override
  void initState() {
    viewModel = DemoTypeViewModel(ref);
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.typeName == "needLogin") {
      return _buildLogin();
    }
    return Center(
        child: Text(widget.typeName, style: AppTextStyle.getBaseStyle()));
  }

  Widget _buildLogin() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(20),
          vertical: UIDefine.getPixelWidth(5)),
      child: Column(
        children: [
          Text("Login--", style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize20)),
          LoginParamView(
              titleText: "account",
              hintText: "input account",
              controller: viewModel.accountController,
              data:
                  ref.watch(globalValidateDataProvider(viewModel.tagAccount))),
          LoginParamView(
              titleText: "password",
              hintText: "input password",
              controller: viewModel.passwordController,
              data:
                  ref.watch(globalValidateDataProvider(viewModel.tagPassword))),
          TextButtonWidget(
              btnText: 'login',
              onPressed: () => viewModel.onPressLogin(context))
        ],
      ),
    );
  }
}
