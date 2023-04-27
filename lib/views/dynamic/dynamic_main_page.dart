import 'package:base_project/view_models/base_view_model.dart';
import 'package:base_project/views/dynamic/dynamic_post_comment_page.dart';
import 'package:flutter/material.dart';

import '../../constant/theme/app_text_style.dart';

class DynamicMainPage extends StatelessWidget {
  const DynamicMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => BaseViewModel()
            .pushPage(context, const DynamicPostCommentPage(postId: "123")),
        child:
            Center(child: Text("dynamic", style: AppTextStyle.getBaseStyle())));
  }
}
