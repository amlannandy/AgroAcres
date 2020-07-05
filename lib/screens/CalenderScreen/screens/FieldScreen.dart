import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/User.dart';
import '../screens/MyCropFieldScreen.dart';
import '../local_widgets/CustomAppBar.dart';
import '../../../widgets/PrimaryButton.dart';
import '../../../widgets/LoadingSpinner.dart';
import '../../../services/UserDatabaseService.dart';

class FieldScreen extends StatelessWidget {

  final UserDatabaseService userDatabaseService = UserDatabaseService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: customAppBar(context, 'Crop Calender'),
      backgroundColor: Colors.white,
      body: user == null ? loadingSpinner() : FutureBuilder<User>(
        future: userDatabaseService.getUser(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingSpinner();
          }
          if (!snapshot.hasData) {
            return Container();
          }
          final user = snapshot.data;
          if (user.fieldId == null) {
            return emptyBanner(context);
          }
          if (user.fieldId != null) {
            return MyCropFieldScreen(user.fieldId);
          }
          return loadingSpinner();
        }
      ),
    );
  }

  Widget emptyBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/empty.png'),
          SizedBox(height: 40),
          Text(
            'Looks like you haven\'t added your Crop Field yet',
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 18,
              color: Colors.green[800].withOpacity(0.7),
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Do it now to get a complete timeline on how to nurture your crop',
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 16,
              color: Colors.green[800].withOpacity(0.7),
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          PrimaryButton(
            text: 'START NOW',
            press: () => Navigator.of(context).pushNamed('/addcropfield'),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}