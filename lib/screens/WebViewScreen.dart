import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import './VideoScreen.dart';

class WebViewScreen extends StatelessWidget {
  final String title;
  final String url;
  final String videoUrl;

  WebViewScreen(this.title, this.url, this.videoUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 22,
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black.withOpacity(0.8),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.help,
                color: Colors.black.withOpacity(0.8),
              ),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => VideoScreen(title, videoUrl))),
            )
          ]),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: WebviewScaffold(
          url: url,
        ),
      ),
    );
  }
}
