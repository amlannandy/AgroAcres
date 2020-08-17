import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../local_widgets/WhiteAppBar.dart';
import '../local_widgets/TutorialsList.dart';
import '../../../services/LocalizationProvider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isEnglish =
        Provider.of<LocalizationProvider>(context).getCurrentLanguage() == 'en';

    return Scaffold(
      appBar: appBar(context, isEnglish ? 'Settings' : 'समायोजन'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            languageSwitch(context, isEnglish),
            Divider(color: Colors.grey, thickness: 0.4),
            SizedBox(height: 5),
            TutorialsList(isEnglish),
          ],
        ),
      ),
    );
  }

  Widget languageSwitch(BuildContext context, bool isEnglish) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: isEnglish ? 'Current Language:   ' : 'वर्तमान भाषा:   ',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 17,
                  ),
                ),
                TextSpan(
                  text: isEnglish ? 'English' : 'हिन्दी',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
          CupertinoSwitch(
            value: isEnglish,
            onChanged: (val) =>
                Provider.of<LocalizationProvider>(context, listen: false)
                    .switchLanguage(!isEnglish),
            activeColor: Colors.green[800],
            trackColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
