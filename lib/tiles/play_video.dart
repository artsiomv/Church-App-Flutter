import 'package:flutter/material.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

class PlayVideo extends StatefulWidget {
  PlayVideo(this.url);
  final String url;

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    String myUrl = widget.url.split('https://youtu.be/')[1];
    final String finalUrl = 'https://www.youtube.com/embed/$myUrl';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(title: Text('Play Video'),),
      ),
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