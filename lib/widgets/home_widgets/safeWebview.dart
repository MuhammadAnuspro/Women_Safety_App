import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SafeWebView extends StatelessWidget {
  //const SafeWebView({super.key});

  final String? url;
  SafeWebView({this.url});

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}