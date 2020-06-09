import 'package:flutter/material.dart';

import '../widgets/PrimaryButton.dart';
import '../screens/WebViewScreen.dart';

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
                builder: (ctx) => WebViewScreen(true),
              ))
            ),
            PrimaryButton(
              text: 'Hindi',
              color: Colors.green[800],
              press: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx) => WebViewScreen(false),
              ))
            ),
          ],
        ),
      ),
    );
  }
}