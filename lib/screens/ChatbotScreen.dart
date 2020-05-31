import 'package:flutter/material.dart';

import '../widgets/CustomAppBar.dart';

class ChatbotScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Chatbot'),
      body: Container(),
    );
  }
}