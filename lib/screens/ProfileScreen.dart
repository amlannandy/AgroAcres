import 'package:AgroAcres/services/UserInfoProvider.dart';
import 'package:AgroAcres/widgets/CustomLightButton.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).accentColor,
            Theme.of(context).primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            customLightButton(
              context: context,
              onPress: () => UserInfoProvider.logOut(context),
              icon: Icons.exit_to_app,
              text: "Sign out"
            ),
          ],
        ),
      ),
    );
  }
}