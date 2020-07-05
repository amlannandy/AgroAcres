import 'package:flutter/material.dart';

import '../widgets/PrimaryButton.dart';
import '../screens/WebViewScreen.dart';

const ENGLISH_URL = 'https://web-chat.global.assistant.watson.cloud.ibm.com/preview.html?region=eu-gb&integrationID=f5f43d26-7f4b-4766-8ab0-427422369987&serviceInstanceID=cd1938af-8ea5-4c50-a686-44c85b08756b';
const HINDI_URL = 'https://web-chat.global.assistant.watson.cloud.ibm.com/preview.html?region=eu-gb&integrationID=d90dc56f-613a-4ca3-a586-dfebb09341d5&serviceInstanceID=cd1938af-8ea5-4c50-a686-44c85b08756b';

class ChatbotScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Converse with our Chatbot',
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 18,
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
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Select your preffered Language',
              style: TextStyle(
                fontFamily: 'Varela',
                color: Colors.black.withOpacity(0.8),
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            PrimaryButton(
              text: 'English',
              color: Colors.green[800],
              press: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx) => WebViewScreen('Welcome', ENGLISH_URL),
              ))
            ),
            PrimaryButton(
              text: 'Hindi',
              color: Colors.green[800],
              press: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx) => WebViewScreen('स्वागत हे', HINDI_URL),
              ))
            ),
          ],
        ),
      ),
    );
  }
}