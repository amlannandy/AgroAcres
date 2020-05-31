import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/User.dart';
import '../widgets/UserInfo.dart' as UserInfo;
import '../widgets/MenuItem.dart';
import '../services/UserInfoProvider.dart';
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

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          userInfo(user),
          menuItem(
            onPress: () => Navigator.of(context).pushNamed('/chatbot'),
            title: 'Chatbot',
            icon: Icons.chat_bubble_outline,
          ),
          menuItem(
            onPress: () => UserInfoProvider.logOut(context),
            title: 'Log out',
            icon: Icons.exit_to_app,
          ),
        ],
      ),
    );
  }
}