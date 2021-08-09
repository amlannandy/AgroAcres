import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/User.dart';
import '../widgets/UserInfo.dart' as UserInfo;
import '../widgets/MenuItem.dart';
import '../../routing/Application.dart';
import '../services/UserInfoProvider.dart';
import '../services/LocalizationProvider.dart';
import '../services/UserDatabaseService.dart';

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
    bool isEnglish = Provider.of<LocalizationProvider>(context).isEnglish;
    String language =
        Provider.of<LocalizationProvider>(context).currentLanguage;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          userInfo(user),
          menuItem(
            onPress: user == null
                ? null
                : () => Application.router
                    .navigateTo(context, '/my-products/${user.uid}'),
            title: isEnglish ? 'My Products' : 'मेरे उत्पाद',
            icon: Icons.storage,
          ),
          menuItem(
            onPress: () => Navigator.of(context).pushNamed('/field'),
            title: isEnglish ? 'Crop Calender' : 'फसल कैलेंडर',
            icon: Icons.calendar_today,
          ),
          menuItem(
            onPress: () =>
                Application.router.navigateTo(context, '/chatbot/$language'),
            title: isEnglish ? 'Chatbot' : 'बॉट चैट करें',
            icon: Icons.chat_bubble_outline,
          ),
          menuItem(
            onPress: () => Application.router.navigateTo(context, '/weather'),
            title: isEnglish ? 'Weather Forecast' : 'मौसम पूर्वानुमान',
            icon: Icons.cloud,
          ),
          menuItem(
            onPress: () =>
                Application.router.navigateTo(context, '/settings/$language'),
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
