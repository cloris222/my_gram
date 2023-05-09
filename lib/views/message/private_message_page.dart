import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivateMessagePage extends ConsumerStatefulWidget {
  const PrivateMessagePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PrivateMessagePageState();
}

class _PrivateMessagePageState extends ConsumerState<PrivateMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        child: Text('private message page'),
      ),
    );
  }
}
