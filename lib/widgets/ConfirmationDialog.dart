import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/LocalizationProvider.dart';

class ConfirmationDialog extends StatelessWidget {
  final Function onConfirm;

  ConfirmationDialog(this.onConfirm);

  @override
  Widget build(BuildContext context) {
    bool isEnglish = Provider.of<LocalizationProvider>(context).isEnglish;

    return AlertDialog(
      title: Text(
        isEnglish ? 'Confirmation' : 'पुष्टीकरण',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Lato',
        ),
      ),
      content: Text(
        isEnglish ? 'Are you sure?' : 'क्या आप पक्के हैं?',
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Lato',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            isEnglish ? 'No' : 'नहीं',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Lato',
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: Text(
            isEnglish ? 'Yes' : 'हाँ',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Lato',
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
