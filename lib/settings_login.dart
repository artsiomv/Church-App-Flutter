import 'package:flutter/material.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

class SettingsLogIn extends StatefulWidget {
  @override
  _SettingsLogInState createState() => _SettingsLogInState();
}

class _SettingsLogInState extends State<SettingsLogIn> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    final String finalUrl = 'https://www.app.lttwchurch.org/LTTW_app_php/';

    return Scaffold(
      appBar: AppBar(title: Text('Log In') ),
      body: WebView( 
        initialUrl: finalUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _controller.complete(controller);
        },
      )
    );
  }
}