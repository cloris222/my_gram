import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common_appbar_view.dart';

class PersonalHomePage extends ConsumerStatefulWidget {
  const PersonalHomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PersonalHomePageState();
}

class _PersonalHomePageState extends ConsumerState<PersonalHomePage> {
  @override
  Widget build(BuildContext context) {
    return CommonAppbarView(
      body: Text('userHomePage'),
      needScrollView: true,
    );
  }
}
