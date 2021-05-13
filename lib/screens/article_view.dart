import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final blogUrl;
  ArticleView({@required this.blogUrl});
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'News',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Mania',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              )
            ],
          ),
          actions: [
            Opacity(
              opacity: 0.0,
              child: Container(
                child: Icon(Icons.save),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
            )
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: WebView(
            initialUrl: widget.blogUrl,
            onWebViewCreated: ((WebViewController webviewController) {
              _completer.complete(webviewController);
            }),
          ),
        ));
  }
}
