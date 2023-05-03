import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/app_text_style.dart';
import '../../widgets/appbar/custom_app_bar.dart';

class PersonalMainPage extends ConsumerStatefulWidget {
  const PersonalMainPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PersonalMainPageState();
}

class _PersonalMainPageState extends ConsumerState<PersonalMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.titleAppBar(context, title: tr("personalPage")),
    );
  }
}

