import 'package:flutter/material.dart';
import 'package:base_project/constant/theme/ui_define.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';


class WebRecaptchaPage extends StatelessWidget {
  const WebRecaptchaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: UIDefine.getPixelWidth(100)),
            child: WebViewPlus(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                controller.loadUrl("assets/webpages/index.html");
              },
              javascriptChannels: {
                JavascriptChannel(
                    name: 'Captcha',
                    onMessageReceived: (JavascriptMessage message) {
                      Navigator.pop(context, true);
                    })
              },
            ),
          ),
        ));
  }
}
