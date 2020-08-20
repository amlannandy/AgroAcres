import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/User.dart';
import '../widgets/UserInfo.dart' as UserInfo;
import '../widgets/MenuItem.dart';
import '../screens/WebViewScreen.dart';
import '../services/UserInfoProvider.dart';
import '../services/LocalizationProvider.dart';
import '../services/UserDatabaseService.dart';

const ENGLISH_URL =
    'https://web-chat.global.assistant.watson.cloud.ibm.com/preview.html?region=eu-gb&integrationID=f5f43d26-7f4b-4766-8ab0-427422369987&serviceInstanceID=cd1938af-8ea5-4c50-a686-44c85b08756b';
const HINDI_URL =
    'https://web-chat.global.assistant.watson.cloud.ibm.com/preview.html?region=eu-gb&integrationID=d90dc56f-613a-4ca3-a586-dfebb09341d5&serviceInstanceID=cd1938af-8ea5-4c50-a686-44c85b08756b';

const CHATBOT_ENGLISH_URL =
    'https://firebasestorage.googleapis.com/v0/b/agroacres-bbsr.appspot.com/o/videos%2FChatbot%20Final-1.m4v?alt=media&token=2e9c4fd4-b423-4a29-af3e-c444a499cdc7';
const CHATBOT_HINDI_URL =
    'https://firebasestorage.googleapis.com/v0/b/agroacres-bbsr.appspot.com/o/videos%2FChatbot%20Final-1.m4v?alt=media&token=2e9c4fd4-b423-4a29-af3e-c444a499cdc7';

class MenuScreen extends StatelessWidget {
  final UserDatabaseService userDatabaseService = UserDatabaseService();

  Widget userInfo(FirebaseUser user) {
    if (user != null) {
      return FutureProvider<User>.value(
        value: userDatabaseService.getUser(user.uid),
        child: UserInfo.UserInfo(),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    bool isEnglish =
        Provider.of<LocalizationProvider>(context).getCurrentLanguage() == 'en';

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          userInfo(user),
          menuItem(
            onPress: () => Navigator.of(context).pushNamed('/myproducts'),
            title: isEnglish ? 'My Products' : 'मेरे उत्पाद',
            icon: Icons.storage,
          ),
          menuItem(
            onPress: () => Navigator.of(context).pushNamed('/field'),
            title: isEnglish ? 'Crop Calender' : 'फसल कैलेंडर',
            icon: Icons.calendar_today,
          ),
          menuItem(
            onPress: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => WebViewScreen(
                isEnglish ? 'Welcome' : 'स्वागत हे',
                isEnglish ? ENGLISH_URL : HINDI_URL,
                isEnglish ? CHATBOT_ENGLISH_URL : CHATBOT_HINDI_URL,
              ),
            )),
            title: isEnglish ? 'Chatbot' : 'बॉट चैट करें',
            icon: Icons.chat_bubble_outline,
          ),
          menuItem(
            onPress: () => Navigator.of(context).pushNamed('/weather'),
            title: isEnglish ? 'Weather Forecast' : 'मौसम पूर्वानुमान',
            icon: Icons.cloud,
          ),
          menuItem(
            onPress: () => Navigator.of(context).pushNamed('/settings'),
            title: isEnglish ? 'Settings' : 'समायोजन',
            icon: Icons.settings,
          ),
          menuItem(
            onPress: () => UserInfoProvider.logOut(context),
            title: isEnglish ? 'Log out' : 'लॉग आउट',
            icon: Icons.exit_to_app,
          ),
        ],
      ),
    );
  }
}
