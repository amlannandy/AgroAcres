import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const ENGLISH_URL = 'https://web-chat.global.assistant.watson.cloud.ibm.com/preview.html?region=eu-gb&integrationID=f5f43d26-7f4b-4766-8ab0-427422369987&serviceInstanceID=cd1938af-8ea5-4c50-a686-44c85b08756b';

const HINDI_URL = 'https://web-chat.global.assistant.watson.cloud.ibm.com/preview.html?region=eu-gb&integrationID=d90dc56f-613a-4ca3-a586-dfebb09341d5&serviceInstanceID=cd1938af-8ea5-4c50-a686-44c85b08756b';

class WebViewScreen extends StatelessWidget {

  final bool isEnglish;

  WebViewScreen(this.isEnglish);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          isEnglish ? 'Welcome' : 'स्वागत हे',
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 22,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.bold
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black.withOpacity(0.8),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(
          bottom: 10
        ),
        child: WebviewScaffold(
          url: isEnglish ? ENGLISH_URL : HINDI_URL,
        ),
      ),
    );
  }
}