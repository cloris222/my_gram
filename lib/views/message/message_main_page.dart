import 'package:flutter/material.dart';

import '../../constant/theme/app_text_style.dart';

class MessageMainPage extends StatelessWidget {
  const MessageMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("message", style: AppTextStyle.getBaseStyle()));
  }
}
